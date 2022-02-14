const queryInventoryWithItems = r'''
query getInventoryWithItems($inventoryID: ID!) {
  inventory(id: $inventoryID) {
    name,
    description,
    items {
      name,
      quantity
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