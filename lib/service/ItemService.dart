import 'package:lista_mercado/models/Item.dart';

class ItemService {
  static List<Item> marketList = <Item>[];

  List<Item> read() {
    marketList.sort((Item item, b) => (item.caught || item.without) ? 1 : -1);
    return marketList;
  }

  void delete(String id) {
    marketList.removeWhere((itemInList) => itemInList.id == id);
  }

  void upsert(Item item) {
    try {
      Item itemList =
          marketList.singleWhere((itemInList) => itemInList.id == item.id);
      itemList.name = item.name;
      itemList.note = item.note;
      itemList.quantity = item.quantity;
      itemList.caught = item.caught;
      itemList.without = item.without;
    } catch (ex) {
      marketList.add(item);
    }
  }

  void markCaught(Item item) {
    item.caught = !item.caught;
    upsert(item);
  }

  void markWithout(Item item) {
    item.without = !item.without;
    upsert(item);
  }
}
