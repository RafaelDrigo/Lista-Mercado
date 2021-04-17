import 'package:flutter/material.dart';
import 'package:lista_mercado/models/Item.dart';
import 'package:lista_mercado/service/ItemService.dart';
import 'package:uuid/uuid.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeView createState() => _HomeView();
}

class _HomeView extends State<HomeView> {
  final service = ItemService();
  List<Item> marketList;

  initState() {
    super.initState();
    this.marketList = service.read();
  }

  callEdit(BuildContext context, Item item) async {
    var result =
        await Navigator.of(context).pushNamed('/save', arguments: item);

    setState(() {
      if (result != null && result == true) {
        this.marketList = service.read();
      }
    });
  }

  Color getColorCart(Item item) {
    if (item.caught) {
      return Colors.greenAccent;
    }

    if (item.without) {
      return Colors.red;
    }

    return Colors.white;
  }

  withoutItem(Item item) {
    service.markWithout(item);
    setState(() => this.marketList = service.read());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("lista de compra"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Flexible(
            flex: 9,
            child: ListView.builder(
              itemCount: marketList.length,
              itemBuilder: (_, indice) {
                Item item = marketList[indice];

                return Card(
                  color: getColorCart(item),
                  child: Dismissible(
                    key: Key(marketList[indice].name),
                    background: Container(color: Colors.red),
                    onDismissed: (direction) {
                      if (direction == DismissDirection.startToEnd) {
                        service.delete(item.id);
                        setState(() => this.marketList = service.read());
                      }
                    },
                    child: CheckboxListTile(
                      title: Row(
                        children: [
                          Row(
                            children: [
                              IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () => callEdit(context, item),
                              ),
                              IconButton(
                                icon: item.without
                                    ? Icon(Icons.bookmark_border_rounded)
                                    : Icon(Icons.backspace_rounded),
                                onPressed: () => withoutItem(item),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(item.name,
                                        overflow: TextOverflow.visible,
                                        maxLines: 1),
                                    Text("Qtd:" + item.quantity.toString()),
                                    Text(item.note,
                                        overflow: TextOverflow.visible,
                                        maxLines: 1),
                                  ]),
                            ],
                          ),
                        ],
                      ),
                      value: item.caught,
                      onChanged: (value) {
                        setState(() {
                          item.caught = value;
                          service.upsert(item);
                          this.marketList = service.read();
                        });
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => callEdit(
            context,
            Item(
                id: Uuid().v4(),
                name: "",
                note: "",
                quantity: 1,
                caught: false,
                without: false)),
      ),
    );
  }
}
