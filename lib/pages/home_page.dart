import 'dart:io';

import 'package:band_names/models/band_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<BandModel> bands = [
    BandModel(id: '1', name: 'metallica', votes: 5),
    BandModel(id: '2', name: 'Queen', votes: 2),
    BandModel(id: '3', name: 'heroes del silencio', votes: 3),
    BandModel(id: '4', name: 'Bon Jovi', votes: 4),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'BandNames',
          style: TextStyle(
            color: Colors.black87,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: bands.length,
        itemBuilder: (BuildContext context, int index) =>
            _bandTile(bands[index]),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        elevation: 1,
        onPressed: addNewBand,
      ),
    );
  }

  Widget _bandTile(BandModel bandModel) {
    return Dismissible(
      key: Key(bandModel.id),
      direction: DismissDirection.startToEnd,
      onDismissed: (DismissDirection dismissDirection) {
        print('direction: $dismissDirection');
        print('direction: ${bandModel.id}');
        // TODO: llamar el borrado en el server
      },
      background: Container(
        padding: EdgeInsets.only(left: 8),
        color: Colors.red,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Delete Band',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      child: ListTile(
        leading: CircleAvatar(
          child: Text(
            bandModel.name.substring(0, 2),
          ),
        ),
        title: Text(bandModel.name),
        trailing: Text(
          '${bandModel.votes}',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        onTap: addNewBand,
      ),
    );
  }

  addNewBand() {
    final TextEditingController textEditingController =
        new TextEditingController();

    if (Platform.isAndroid) {
      return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('New band name:'),
            content: TextField(
              controller: textEditingController,
            ),
            actions: [
              MaterialButton(
                child: Text('Add'),
                elevation: 5,
                textColor: Colors.blue,
                onPressed: () => addBandToList(
                  name: textEditingController.text,
                ),
              )
            ],
          );
        },
      );
    }

    showCupertinoDialog(
      context: context,
      builder: (_) {
        return CupertinoAlertDialog(
          title: Text('New band Name'),
          content: CupertinoTextField(
            controller: textEditingController,
          ),
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              child: Text('Add'),
              onPressed: () => addBandToList(
                name: textEditingController.text,
              ),
            ),
            CupertinoDialogAction(
              isDestructiveAction: true,
              child: Text('DIssmiss'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }

  void addBandToList({String name}) {
    if (name.length > 1) {
      this.bands.add(
          new BandModel(id: DateTime.now().toString(), name: name, votes: 0));
      setState(() {});
    }
    Navigator.pop(context);
  }
}
