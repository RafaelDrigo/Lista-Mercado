import 'package:flutter/material.dart';
import 'package:lista_mercado/view/SaveItem.view.dart';
import 'package:lista_mercado/view/Home.view.dart';

class Routes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(routes: {
      '/': (context) => HomeView(),
      '/save': (context) => SaveItemView()
    }, initialRoute: '/');
  }
}
