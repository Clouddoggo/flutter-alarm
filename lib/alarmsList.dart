import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'storage.dart';

class AlarmsListPage extends StatefulWidget {
  AlarmsListPage({Key key}) : super(key: key);

  @override
  _AlarmsListPageState createState() => _AlarmsListPageState();
}

class _AlarmsListPageState extends State<AlarmsListPage> {
  String _time;

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 1), (Timer t) => _getTime());
  }

  void _getTime() {
    print("getting time");
    final String formattedDateTime =
        DateFormat('kk:mm\nMM-dd').format(DateTime.now()).toString();
    setState(() {
      _time = formattedDateTime;
    });
  }

  Future navigateToPage(context, page) async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot document) {
    return ListTile(
      title: Text("time picker"),
      subtitle: Text(
        document.get('name'),
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w400,
        ),
      ),
      trailing: IconButton(
        icon: Icon(
          Icons.delete_outline,
          size: 20,
        ),
        highlightColor: Colors.redAccent,
        onPressed: () {
          print("deleting");
        },
      ),
      onTap: () {
        print("tapped");
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SafeArea(
          child: Container(
            child: Column(children: [
              Text(_time),
              SizedBox(
                height: 20,
              ),
              StreamBuilder(
                stream: Storage.getStream(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                        child: Text(
                      'no alarms yet',
                    ));
                  }
                  return ListView.builder(
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (context, index) => _buildListItem(
                          context, snapshot.data.documents[index]));
                },
              ),
            ]),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print("pressed");
        },
        child: Icon(Icons.add_alarm),
        backgroundColor: Colors.amber[400],
        elevation: 15,
      ),
    );
  }
}
