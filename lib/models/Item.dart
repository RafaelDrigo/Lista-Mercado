class Item {
  String id;
  String name;
  String note;
  int quantity;
  bool caught;
  bool without;

  Item(
      {this.id,
      this.name,
      this.note,
      this.quantity = 1,
      this.caught = false,
      this.without = false});
}
