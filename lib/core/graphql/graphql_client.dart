import 'package:fluent_ui/fluent_ui.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

final graphQLApiLink = HttpLink("http://localhost:8081/query");

ValueNotifier<GraphQLClient> graphQLClient(String token) {
  final link = token.isNotEmpty ? 
    AuthLink(getToken: () => "Bearer $token").concat(graphQLApiLink) : 
    graphQLApiLink;
  return ValueNotifier(
    GraphQLClient(
      cache: GraphQLCache(store: InMemoryStore()),
      link: link
    )
  );
}