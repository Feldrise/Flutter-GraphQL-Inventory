const String mutationAuthenticationRegister = r'''
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

const String mutationAuthenticationLogin = r'''
mutation Login($email: String!, $password: String!) {
  login(input: {
    email: $email,
    password: $password
  })
}
''';