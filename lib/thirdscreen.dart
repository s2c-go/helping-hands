import 'package:flutter/material.dart';
import 'package:helpinghand/disaster_detail.dart';
import 'dart:async';
import 'disaster.dart';
import 'database_helper.dart';
import 'package:flurry_navigation/flurry_navigation.dart';
import 'package:sqflite/sqflite.dart';

final Screen thirdscreen = new Screen(
    contentBuilder: (BuildContext context) {
      return ReadingList();
    }
);

class ReadingList extends StatefulWidget{


  @override
  ReadingListState createState() => ReadingListState();
}

class ReadingListState extends State<ReadingList>{

  DatabaseHelper  databaseHelper = DatabaseHelper();
  List<Disaster> disasterList;
  int count = 0;


  @override
  Widget build(BuildContext context) {

    if(disasterList == null){
      disasterList  = List<Disaster>();
      updateListView();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Disasters'),
      ),
      body: getReadingListView(),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          debugPrint('FAB Clicked');
          navigateTodisasterDetail(Disaster('', ''), 'Add Disaster');
        },
        tooltip: 'Add Disaster',
        child: Icon(Icons.add),
      ),
    );
  }

  ListView getReadingListView(){
    TextStyle titleStyle = Theme.of(context).textTheme.subhead;

    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position){
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.yellow,
              child: Icon(Icons.bubble_chart),
            ),
            title: Text(this.disasterList[position].title, style: titleStyle),
            subtitle: Text(this.disasterList[position].description),

            trailing: GestureDetector(
              child: Icon(Icons.delete, color: Colors.grey),
              onTap: (){
                _delete(context, disasterList[position]);
              }
            ),

            onTap: (){
              debugPrint("ListTile Tapped");
              navigateTodisasterDetail(this.disasterList[position], 'Edit');
            },
          )
        );
      },
    );
  }

  void _delete(BuildContext context, Disaster disaster) async{
    int result = await databaseHelper.deletedisaster(disaster.id);
    if(result!=0){
      _showSnackBar(context, 'Disaster deleted successfully');
      updateListView();
    }
  }

  _showSnackBar(BuildContext context, String message){
    final snackBar = SnackBar(content: Text(message));
    Scaffold.of(context).showSnackBar(snackBar);
  }

  void navigateTodisasterDetail(Disaster disaster, String title) async{
    bool result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context){
              // return disasterDetail(disaster, title);
              return DisasterDetail(disaster, title);
            }
        )
    );
    if(result == true){
      updateListView();
    }
  }

  void updateListView(){
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database){

      Future<List<Disaster>> disasterListFuture = databaseHelper.getdisasterList();
      disasterListFuture.then((disasterList){
        setState((){
          this.disasterList = disasterList;
          this.count = disasterList.length;
        });
      });
    });
  }
}

