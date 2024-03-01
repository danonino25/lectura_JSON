import 'dart:convert';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'Item.dart';

class JsonListViewScreen extends StatefulWidget {
  @override
  _JsonListViewScreenState createState() => _JsonListViewScreenState();
}

class _JsonListViewScreenState extends State<JsonListViewScreen> {
  late List<Item> items;

  @override
  void initState() {
    super.initState();
    loadItems();
  }

  Future<void> loadItems() async {
    // Carga el JSON desde el archivo assets
    String jsonString =
        await DefaultAssetBundle.of(context).loadString('assets/data.json');
    List<dynamic> jsonList = json.decode(jsonString);

    // Convierte el JSON en objetos Dart
    setState(() {
      items = jsonList.map((item) => Item.fromJson(item)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Lista de Elementos',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue, // Color de fondo del AppBar
      ),
      body: items != null
          ? ListView.builder(
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) {
                return _buildListItem(context, items[index]);
              },
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  Widget _buildListItem(BuildContext context, Item item) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      color: Colors.white, // Color de fondo del Card
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: Colors.blue, width: 2),
      ),
      child: ListTile(
        title: Text(
          item.name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.blue, // Color del título
          ),
        ),
        subtitle: Text(
          'ID: ${item.id}',
          style: TextStyle(
            fontStyle: FontStyle.italic,
            color: Colors.grey[600], // Color del subtítulo
          ),
        ),
        onTap: () {
          // Acción al hacer tap en el elemento, si es necesario
        },
      ),
    );
  }
}
