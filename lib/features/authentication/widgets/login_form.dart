import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:graphql_inventory/core/widgets/status_message.dart';
import 'package:graphql_inventory/features/authentication/app_user_controller.dart';
import 'package:graphql_inventory/features/authentication/authentication_graphql.dart';

class LoginForm extends ConsumerStatefulWidget {
  const LoginForm({
    Key? key,
    required this.onRegisterPressed,
  }) : super(key: key);

  final Function() onRegisterPressed;

  @override
  ConsumerState<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends ConsumerState<LoginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;
  String _statusMessage = "";

  @override
  Widget build(BuildContext context) {
    return Mutation(
      options: MutationOptions(
        document: gql(mutationAuthenticationLogin),
        onCompleted: (dynamic data) {
          if (data == null) return;
          final mapData = data as Map<String, dynamic>;

          ref.read(appUserControllerProvider.notifier).loginUser(mapData["login"] as String);
        },
        onError: (error) {
          setState(() {
            _isLoading = false;
            _statusMessage = "Impossible de vous connecter. Verifiez le mot de passe et l'adresse mail.";
          });
        },
      ),
      builder: (runMutation, result) => SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: _isLoading ? const ProgressRing() : Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (_statusMessage.isNotEmpty) ...{
                GQLStatusMessage(
                  message: _statusMessage,
                ),
                const SizedBox(height: 24,),
              },

              // The page title
              Text(
                "Se connecter",
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
                placeholder: "Rentrer votre mot de passe...",
                obscureText: true,
                validator: (value) {
                  if ((value ?? "").isEmpty) return "Vous devez rentrer un mot de passe";

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
                      child: const Text("Se connecter"),
                      onPressed: () => _onLoginClicked(runMutation),
                    ),
                  ),
                  const SizedBox(width: 12,),
              
                  // The login button
                  Expanded(
                    child: Button(
                      child: const Text("Pas encore inscrit ?"),
                      onPressed: widget.onRegisterPressed,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      )
    );
  }

  Future _onLoginClicked(RunMutation runMutation) async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    final email = _emailTextController.text;
    final password = _passwordController.text;

    runMutation(<String, dynamic>{
      "email": email,
      "password": password,
    });
  }
}