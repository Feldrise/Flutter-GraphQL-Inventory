import 'package:fluent_ui/fluent_ui.dart';
import 'package:graphql_inventory/features/inventories/inventory.dart';

class InventoryDialog extends StatefulWidget {
  const InventoryDialog({
    Key? key,
    this.name,
    this.description
  }) : super(key: key);

  final String? name;
  final String? description;

  @override
  State<InventoryDialog> createState() => _InventoryDialogState();
}

class _InventoryDialogState extends State<InventoryDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _nameTextController = TextEditingController();
  final TextEditingController _descriptionTextController = TextEditingController();

  void _initializeValues() {
    _nameTextController.text = widget.name ?? "";
    _descriptionTextController.text = widget.description ?? "";
  }

  @override
  void initState() {
    super.initState();

    _initializeValues();
  }

  @override
  void didUpdateWidget(covariant InventoryDialog oldWidget) {
    super.didUpdateWidget(oldWidget);

    _initializeValues();
  }

  @override
  Widget build(BuildContext context) {
    final String title = widget.name == null || widget.description == null ?
      "Créer un inventaire" : 
      "Mettre à jour l'inventaire ${widget.name}";

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
                header: "Nom de l'inventaire",
                placeholder: "Choisir un nom...",
                validator: (value) {
                  if ((value ?? "").isEmpty) return "Vous devez choisir un nom";

                  return null;
                },
              ),

              // The description field
              TextFormBox(
                controller: _descriptionTextController,
                header: "Description de l'inventaire",
                placeholder: "Choisir une description...",
                keyboardType: TextInputType.multiline,
                maxLines: 5,
                validator: (value) {
                  if ((value ?? "").isEmpty) return "Vous devez rentrer une description";

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

    final inventory = Inventory(
      name: _nameTextController.text,
      description: _descriptionTextController.text 
    );

    Navigator.of(context).pop(inventory);
  }
}