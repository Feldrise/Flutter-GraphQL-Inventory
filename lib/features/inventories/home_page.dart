import 'package:fluent_ui/fluent_ui.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:graphql_inventory/core/widgets/status_message.dart';
import 'package:graphql_inventory/features/inventories/inventories_graphql.dart';
import 'package:graphql_inventory/features/inventories/inventory.dart';
import 'package:graphql_inventory/features/inventories/widget/inventory_dialog.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isSuccess = false;
  bool _shouldRefetch = false;
  String _statusMessage = "";

  @override
  Widget build(BuildContext context) {
    return Mutation(
      options: MutationOptions(
        document: gql(mutationInventoriesCreate),
        onError: (error) {
          setState(() {
            _isSuccess = false;
            _statusMessage = "Nous n'avons pas réussi à créer l'inventaire...";
          });
        },
        onCompleted: (dynamic data) {
          if (data == null) return;

          setState(() {
            _isSuccess = true;
            _shouldRefetch = true;
            _statusMessage = "L'inventaire à bien été créé";
          });
        },
      ),
      builder: (runMutation, mutationResult) =>
        ScaffoldPage(
          header: PageHeader(
            title: const Text("Vos inventaires"),
            commandBar: IconButton(
              icon: const Icon(FluentIcons.add), 
              onPressed: () => _onAddInventoryPressed(context, runMutation),
            )
          ),
          content: Padding(
            padding: const EdgeInsets.all(24.0),
            child:Query(
              options: QueryOptions(
                document: gql(queryInventoriesSimplified),
              ),
              builder: (queryResult, {fetchMore, refetch}) {
                if (_shouldRefetch) {
                  refetch!();
                  _shouldRefetch = false;
                }

                if (queryResult.hasException) {
                  return const Align(
                    alignment: Alignment.topCenter,
                    child: SizedBox(
                      width: double.infinity,
                      child: GQLStatusMessage(
                        title: "Erreur de chargement",
                        message: "Nous n'arrivons pas à charger les inventaires... Vérifiez votre connexion internet et recommencer.",
                      ),
                    ),
                  );
                }

                if (queryResult.isLoading) {
                  return const Center(child: ProgressRing(),);
                }

                final List inventories = queryResult.data!["inventories"] as List;

                return Column(
                  children: [
                    if (mutationResult?.isLoading ?? false) 
                      const ProgressRing(),
                    if (_statusMessage.isNotEmpty) ...{
                      SizedBox(
                        width: double.infinity,
                        child: GQLStatusMessage(
                          message: _statusMessage,
                          type: _isSuccess ? GQLStatusMessageType.success : GQLStatusMessageType.error,
                        ),
                      ),
                      const SizedBox(height: 12,)
                    },
                    Expanded(
                      child: ListView.separated(
                        separatorBuilder: (context, index) => const SizedBox(height: 4,),
                        itemCount: inventories.length,
                        itemBuilder: (context, index) {
                          final Inventory inventory = Inventory.fromJson(inventories[index] as Map<String, dynamic>);

                          return TappableListTile( 
                            leading: const CircleAvatar(
                            child: Icon(FluentIcons.cube_shape),
                            ),
                            title: Text(inventory.name),
                            subtitle: Text(inventory.description),
                            onTap: () {},
                          );
                        }
                      ),
                    ),
                  ],
                );
              },
            ),
          )
        )
    );
  }

  Future _onAddInventoryPressed(BuildContext context, RunMutation runMutation) async {
    final Inventory? newInventory = await showDialog(
      context: context, 
      builder: (context) => const InventoryDialog()
    );

    if (newInventory == null) return;

    runMutation(<String, dynamic>{
      "name": newInventory.name,
      "description": newInventory.description
    });
  }
}