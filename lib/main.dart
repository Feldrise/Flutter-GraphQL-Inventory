import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:graphql_inventory/core/graphql/graphql_client.dart';
import 'package:graphql_inventory/features/authentication/app_user_controller.dart';
import 'package:graphql_inventory/features/authentication/authentication_page.dart';
import 'package:graphql_inventory/features/inventories/home_page.dart';
import 'package:graphql_inventory/theme/gql_theme.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}
class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String userToken = ref.watch(appUserControllerProvider).token; 

    return GraphQLProvider(
      client: graphQLClient(userToken),
      child: FluentApp(
        title: 'GraphQL Flutter Demo',
        theme: GQLTheme.theme(context),
        home: userToken.isNotEmpty ? const HomePage() : const AuthenticationPage()
      ),
    );
  }
}