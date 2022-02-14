import 'package:fluent_ui/fluent_ui.dart';
import 'package:graphql_inventory/features/items/item.dart';

class ItemDialog extends StatefulWidget {
  const ItemDialog({
    Key? key,
    this.name,
    this.quantity
  }) : super(key: key);

  final String? name;
  final int? quantity;

  @override
  State<ItemDialog> createState() => _ItemDialogState();
}

class _ItemDialogState extends State<ItemDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _nameTextController = TextEditingController();
  final TextEditingController _quantityTextController = TextEditingController();

  void _initializeValues() {
    _nameTextController.text = widget.name ?? "";
    _quantityTextController.text = widget.quantity?.toString() ?? "";
  }

  @override
  void initState() {
    super.initState();

    _initializeValues();
  }

  @override
  void didUpdateWidget(covariant ItemDialog oldWidget) {
    super.didUpdateWidget(oldWidget);

    _initializeValues();
  }

  @override
  Widget build(BuildContext context) {
    final String title = widget.name == null || widget.quantity == null ?
      "Créer un item" : 
      "Mettre à jour l'item ${widget.name}";

    return ContentDialog(
      title: Text(title),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // The name field
              TextFormBox(
                controller: _nameTextController,
                header: "Nom de l'item",
                placeholder: "Choisir un nom...",
                validator: (value) {
                  if ((value ?? "").isEmpty) return "Vous devez choisir un nom";

                  return null;
                },
              ),

              // The description field
              TextFormBox(
                controller: _quantityTextController,
                header: "Nombre d'item",
                placeholder: "Quantité",
                keyboardType: TextInputType.number,
                validator: (value) {
                  if ((value ?? "").isEmpty) return "Vous devez rentrer une quantité";
                  
                  final int? quantity = int.tryParse(value ?? "");
                  if (quantity == null) return "Veuillez rentrer un nombre valide";
                  if (quantity <= 0) return "Vous devez avoir une quantité supérieur à zéro";

                  return null;
                },
              )
            ],
          ),
        ),
      ),
      actions: [
        FilledButton(
          child: const Text("Sauvegarder"), 
          onPressed: _onValidated
        ),
        Button(
          child: const Text("Annuler"),
          onPressed: () => Navigator.of(context).pop(),
        )
      ],
    );  
  }

  void _onValidated() {
    if (!_formKey.currentState!.validate()) return;

    final item = Item(
      name: _nameTextController.text,
      quantity: int.parse(_quantityTextController.text) 
    );

    Navigator.of(context).pop(item);
  }
}