const queryInventoryWithItems = r'''
query getInventoryWithItems($inventoryID: ID!, $number: Int!, $after: ID) {
  inventory(id: $inventoryID) {
    name,
    description,
    items(first: $number, after: $after) {
      edges {
        node {
          name,
          quantity
        }
      },
      pageInfo {
        startCursor,
        endCursor,
        hasNextPage
      }
    }
  }
}
''';

const mutationItemCreate = r'''
mutation createItem($inventoryID: ID!, $name: String!, $quantity: Int!) {
  createInventoryItem(input: {
    inventoryID: $inventoryID,
    name: $name,
    quantity: $quantity
  }) {
    name
  }
}
''';