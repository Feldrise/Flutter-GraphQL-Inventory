import 'package:fluent_ui/fluent_ui.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:graphql_inventory/core/graphql/graphql_client.dart';
import 'package:graphql_inventory/features/authentication/authentication_page.dart';
import 'package:graphql_inventory/theme/gql_theme.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: graphQLClient,
      child: FluentApp(
        title: 'GraphQL Flutter Demo',
        theme: GQLTheme.theme(context),
        home: const AuthenticationPage()
      ),
    );
  }
}