import 'package:fluent_ui/fluent_ui.dart';

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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
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

  }
}