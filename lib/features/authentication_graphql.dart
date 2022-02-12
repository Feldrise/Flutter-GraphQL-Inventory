import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:graphql_inventory/core/graphql/graphql_client.dart';

class AuthenticationGraphQL {
  AuthenticationGraphQL._();

  static final instance = AuthenticationGraphQL._();

  Future<bool> registerUser(String email, String password) async {
    const String createUser = r'''
      mutation CreateUser($email: String!, $password: String!) {
        createUser(input: {
          email: $email,
          password: $password
        }) {
          id,
          email
        }
      }
    ''';

    final MutationOptions options = MutationOptions(
      document: gql(createUser),
      variables: <String, dynamic>{
        "email": email,
        "password": password
      }
    );

    final QueryResult result = await graphQLClient.value.mutate(options); 

    if (result.hasException) {
      return false;
    }

    return true;
  }
}