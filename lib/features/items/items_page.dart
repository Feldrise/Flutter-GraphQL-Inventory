import 'package:fluent_ui/fluent_ui.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:graphql_inventory/core/widgets/status_message.dart';
import 'package:graphql_inventory/features/inventories/inventory.dart';
import 'package:graphql_inventory/features/items/item.dart';
import 'package:graphql_inventory/features/items/items_graphql.dart';
import 'package:graphql_inventory/features/items/widgets/item_dialog.dart';
import 'package:graphql_inventory/features/items/widgets/items_list.dart';

class ItemsPage extends StatefulWidget {
  const ItemsPage({
    Key? key,
    required this.inventoryId
  }) : super(key: key);

  final String inventoryId;

  @override
  State<ItemsPage> createState() => _ItemsPageState();
}

class _ItemsPageState extends State<ItemsPage> {
  bool _isSuccess = false;
  bool _shouldRefetch = false;
  String _statusMessage = "";

  @override
  Widget build(BuildContext context) {
    return NavigationView(
      appBar: const NavigationAppBar(height: 0),
      pane: NavigationPane(
        // size: NavigationPaneSize(topHeight: 0),
        displayMode: PaneDisplayMode.top
      ),
      content: Mutation(
        options: MutationOptions(
          document: gql(mutationItemCreate),
          onError: (error) {
            setState(() {
              _isSuccess = false;
              _statusMessage = "Nous n'avons pas réussi à créer l'item...";
            });
          },
          onCompleted: (dynamic data) {
            if (data == null) return;

            setState(() {
              _isSuccess = true;
              _shouldRefetch = true;
              _statusMessage = "L'item à bien été créé";
            });
          },
        ),
        builder: (runMutation, mutationResult) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Query(
            options: QueryOptions(
              document: gql(queryInventoryWithItems),
              variables: <String, dynamic>{
                "inventoryID": widget.inventoryId
              },
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
                      message: "Nous n'arrivons pas à charger cet inventaire... Vérifiez votre connexion internet et recommencer.",
                    ),
                  ),
                );
              }

              if (queryResult.isLoading) {
                return const Center(child: ProgressRing(),);
              }

              final Inventory inventory = Inventory.fromJson(queryResult.data!["inventory"] as Map<String, dynamic>);
              final List mapItems = queryResult.data!["inventory"]["items"] as List;
              final List<Item> items = [];

              for (final mapItem in mapItems) {
                items.add(Item.fromJson(mapItem as Map<String, dynamic>));
              }
              
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
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

                  // The inventory title
                  Text(inventory.name, style: FluentTheme.of(context).typography.titleLarge,),

                  // The inventory description,
                  Text(inventory.description, style: FluentTheme.of(context).typography.bodyLarge,),

                  // The items list
                  Expanded(child: ItemsList(items: items,)),

                  // The add button
                  FilledButton(
                    child: const Text("Ajouter un item"), 
                    onPressed: () => _onAddItemPressed(context, runMutation)
                  )
                ],
              );
            },
          ),
        )
      ),
    );
  }

  Future _onAddItemPressed(BuildContext context, RunMutation runMutation) async {
    final Item? newItem = await showDialog(
      context: context, 
      builder: (context) => const ItemDialog()
    );

    if (newItem == null) return;

    runMutation(<String, dynamic>{
      "inventoryID": widget.inventoryId,
      "name": newItem.name,
      "quantity": newItem.quantity
    });
  }
}