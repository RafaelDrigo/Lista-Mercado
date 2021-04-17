import 'package:flutter/material.dart';
import 'package:lista_mercado/models/Item.dart';
import 'package:lista_mercado/service/ItemService.dart';

class SaveItemView extends StatelessWidget {
  final _service = ItemService();
  final _form = GlobalKey<FormState>();
  Item _item = Item();

  save(BuildContext context) {
    if (_form.currentState.validate()) {
      _form.currentState.save();
      _service.upsert(_item);
      Navigator.of(context).pop(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    _item = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text("Salvar item"),
        centerTitle: false,
      ),
      body: Container(
        margin: const EdgeInsets.all(15),
        child: Form(
          key: _form,
          child: Column(children: [
            SizedBox(height: 5),
            TextFormField(
              autofocus: true,
              initialValue: _item.name,
              decoration: InputDecoration(
                labelText: "Nome",
                border: OutlineInputBorder(),
              ),
              onSaved: (value) => _item.name = value,
              validator: (value) => value.isEmpty ? "Informe Nome" : null,
            ),
            SizedBox(height: 5),
            TextFormField(
              initialValue: _item.note,
              decoration: InputDecoration(
                labelText: "Observação",
                border: OutlineInputBorder(),
              ),
              onSaved: (value) => _item.note = value,
            ),
            SizedBox(height: 5),
            TextFormField(
              initialValue: _item.quantity.toString(),
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Quantidade",
                border: OutlineInputBorder(),
              ),
              onSaved: (value) => _item.quantity = int.parse(value),
            ),
          ]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.save),
        onPressed: () => save(context),
      ),
    );
  }
}
