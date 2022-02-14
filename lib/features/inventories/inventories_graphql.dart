const queryInventoriesSimplified = r'''
query getInventoriesSimplified {
  inventories {
    id,
    name,
    description
  }
}
''';

const mutationInventoriesCreate = r'''
mutation createInventory($name: String!, $description: String!) {
  createInventory(input: {
    name: $name,
    description: $description
  }) {
    name,
    description
  }
}
''';