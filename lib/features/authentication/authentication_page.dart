
import 'package:fluent_ui/fluent_ui.dart';
import 'package:graphql_inventory/features/authentication/widgets/register_form.dart';

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({Key? key}) : super(key: key);

  @override
  State<AuthenticationPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  bool _showRegisterForm = true;

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = MediaQuery.of(context).size.width * 0.1;

    return ScaffoldPage(
      header: const PageHeader(
        title: Text("Bienvenue"),
      ),
      content: Padding(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 32),
        child: Center(
          child: _showRegisterForm ? RegisterForm(onLoginPressed: _onLoginClicked,) : const Text("Hey you want to login")
        ),
      ),
    );
  }

  void _onLoginClicked() {
    setState(() {
      _showRegisterForm = false;
    });
  }
}