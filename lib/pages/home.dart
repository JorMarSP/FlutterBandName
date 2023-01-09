// ignore_for_file: avoid_print

import 'package:band_names/models/band.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<Band> bands = [
    Band(id: '1', name: 'Queen', votes: 5),
    Band(id: '2', name: 'Metalica', votes: 8),
    Band(id: '3', name: 'Decadentes', votes: 10)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        title: const Text("Bands Name", style: TextStyle (color: Colors.black87)),
        backgroundColor: Colors.white,
      ),
      body: ListView.builder(itemCount: bands.length, itemBuilder: (BuildContext context, int index) {
        return _bandTile(bands[index]);
       },),
       floatingActionButton: FloatingActionButton(
        elevation: 5,
        onPressed: addNewBand,
        child: const Icon(Icons.add),
      ),
   );
  }

  Widget _bandTile(Band band) {
    return Dismissible(
      key: Key(band.id),
      onDismissed: (direction) {
        bands.removeWhere((element) => element.id == band.id,);
        print(band.name);
      },
      direction: DismissDirection.startToEnd,
      background: Container(
        padding: const EdgeInsets.only(left: 8.0),
        color: Colors.red,
        child: const Align(
          alignment: Alignment.centerLeft,
          child: Text('Remove Band', style: TextStyle(color: Colors.white),)),
      ),
      child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.blue[100],
            child: Text(band.name.substring(0,2))),
          title: Text(band.name),
          trailing: Text('${band.votes}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          onTap: () {
            print(band.name);
          },
        ),
    );
  }

  addNewBand(){
    final TextEditingController textNewBandController = TextEditingController();
    showDialog(
      context: context, 
      builder: ((context) {
        return AlertDialog(
          title: const Text('New Band Name:'),
          content: TextField(
            controller: textNewBandController,
          ),
          actions: <Widget>[
            MaterialButton(
              elevation: 5,
              child: const Text('Add', style: TextStyle(color: Colors.blue),),
              onPressed: () => addBandToList(textNewBandController.text)
            )
          ],
        );
      })
    );
  }

  void addBandToList(String name) {

    if (name.length > 3){
      final firstLetter = name.substring(0,1);
      final moreLetter = name.substring(1,name.length);
      name = firstLetter.toUpperCase() + moreLetter.toLowerCase();
      bands.add(Band(id: DateTime.now().toString(), name: name, votes: 0));
      setState(() {
        
      });
      Navigator.pop(context);
    }

  }


}

