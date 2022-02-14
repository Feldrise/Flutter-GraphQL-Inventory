import 'package:fluent_ui/fluent_ui.dart';
import 'package:graphql_inventory/features/items/item.dart';

class ItemsList extends StatelessWidget {
  const ItemsList({
    Key? key,
    required this.items,
  }) : super(key: key);

  final List<Item> items;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(FluentIcons.sad, size: 78,),
            const SizedBox(height: 12,),
            Text(
              "Vous n'avez pas encore d'item dans cet inventaire...",
              style: FluentTheme.of(context).typography.subtitle,
            )
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) => TappableListTile(
        leading: const CircleAvatar(
          child: Icon(FluentIcons.cube_shape),
        ),
        title: Text(items[index].name),
        subtitle: Text("Quantité : ${items[index].quantity}"),
        trailing: IconButton(
          icon: const Icon(FluentIcons.delete),
          onPressed: () {},
        ),
        onTap: () {},
      ),
    );
  }
}