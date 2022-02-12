import 'package:fluent_ui/fluent_ui.dart';
import 'package:graphql_inventory/core/widgets/status_message.dart';
import 'package:graphql_inventory/features/authentication_graphql.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({
    Key? key,
    required this.onLoginPressed,
  }) : super(key: key);

  final Function() onLoginPressed;

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmationController = TextEditingController();

  bool _isLoading = false;
  bool _hasSuccessfullyRegistered = false;
  String _statusMessage = "";

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: _isLoading ? const ProgressRing() : Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (_statusMessage.isNotEmpty) ...{
              GQLStatusMessage(
                message: _statusMessage,
                type: _hasSuccessfullyRegistered ? GQLStatusMessageType.success : GQLStatusMessageType.error,
              ),
              const SizedBox(height: 24,),
            },

            // The page title
            Text(
              "Inscrivez vous",
              style: FluentTheme.of(context).typography.subtitle
            ),
            const SizedBox(height: 24,),
      
            // The email form
            TextFormBox(
              controller: _emailTextController,
              header: "Votre email",
              placeholder: "Rentrez votre email...",
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if ((value ?? "").isEmpty) return "Vous devez rentrer un email";

                final bool isEmailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value!);
                if (!isEmailValid) return "L'adresse email est invalide";
      
                return null;
              },
            ),

            // The password form
            TextFormBox(
              controller: _passwordController,
              header: "Votre mot de passe",
              placeholder: "Choisir un mot de passe...",
              obscureText: true,
              validator: (value) {
                if ((value ?? "").isEmpty) return "Vous devez rentrer un mot de passe";

                return null;
              },
            ),

            // The confirmation password form
            TextFormBox(
              controller: _passwordConfirmationController,
              header: "Confirmez votre mot de passe",
              placeholder: "Confirmez votre mot de passe...",
              obscureText: true,
              validator: (value) {
                if ((value ?? "").isEmpty) return "Vous devez rentrer une confirmation";

                if (value! != _passwordController.text) return "La confirmation ne correspond pas au mot de passe";

                return null;
              },
            ),

            // The bottom button
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              children: [
                // The register button
                Expanded(
                  child: FilledButton(
                    child: const Text("S'inscrire"),
                    onPressed: _onRegisterClicked,
                  ),
                ),
                const SizedBox(width: 12,),
            
                // The login button
                Expanded(
                  child: Button(
                    child: const Text("Déjà inscrit ?"),
                    onPressed: widget.onLoginPressed,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Future _onRegisterClicked() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    final email = _emailTextController.text;
    final password = _passwordController.text;

    final hasBeenRegistered = await AuthenticationGraphQL.instance.registerUser(email, password);

    if (hasBeenRegistered) {
      setState(() {
        _isLoading = false;
        _hasSuccessfullyRegistered = true;
        _statusMessage = "Bravo, vous avez bien été inscrit. Vous pouvez maintenant confirmer votre adresse email avant de vous connecter.";
      });
    } else {
      setState(() {
        _isLoading = false;
        _hasSuccessfullyRegistered = false;
        _statusMessage = "Désolé, nous n'avons pas réussi à vous inscrire...";
      });
    }
  }
}