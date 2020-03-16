import 'package:flutter/material.dart';
import 'disaster.dart';
import 'database_helper.dart';
import 'package:intl/intl.dart';

class DisasterDetail extends StatefulWidget{

  final String appBarTitle;
  final Disaster disaster;

  DisasterDetail(this.disaster, this.appBarTitle);
  @override
  DisasterDetailState createState() => DisasterDetailState(this.disaster, this.appBarTitle);
}

class DisasterDetailState extends State<DisasterDetail>{

  DatabaseHelper helper = DatabaseHelper();

  String appBarTitle;
  Disaster disaster;

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  DisasterDetailState(this.disaster, this.appBarTitle);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    TextStyle textStyle = Theme.of(context).textTheme.title;

    titleController.text = disaster.title;
    descriptionController.text = disaster.description;

    return WillPopScope(

      onWillPop: (){
        moveToLastScreen();
      },

      child: Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            moveToLastScreen();
          },
        )
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
        child: ListView(
          children: <Widget>[

            //First Element
            Padding(
              padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: TextField(
                controller: titleController,
                style: textStyle,
                onChanged: (value){
                  debugPrint('Something happned in title!');
                  updateTitle();
                },
                decoration: InputDecoration(
                  labelText: 'Title',
                  labelStyle: textStyle,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  )
                )
              ),
            ),

            //Second Element
            Padding(
              padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: TextField(
                  controller: descriptionController,
                  style: textStyle,
                  onChanged: (value){
                    debugPrint('Something happned in Description!');
                    updateDescription();
                  },
                  decoration: InputDecoration(
                      labelText: 'Description',
                      labelStyle: textStyle,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      )
                  )
              ),
            ),

            //third element in column, has two buttons in a row
            Padding(
              padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: RaisedButton(
                      color: Theme.of(context).primaryColorDark,
                      textColor: Colors.white,
                      elevation: 7.0,
                      shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
                      child: Text(
                        'Save',
                        textScaleFactor: 1.5,
                      ),
                      onPressed: (){
                        setState((){
                          debugPrint('Pressing the save button');
                          _save();
                        });
                      }
                    )
                  ),

                  Container( width: 5.0),
                  Expanded(
                      child: RaisedButton(
                          color: Theme.of(context).primaryColorDark,
                          textColor: Colors.white,
                          elevation: 7.0,
                          shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
                          child: Text(
                            'Delete',
                            textScaleFactor: 1.5,
                          ),
                          onPressed: (){
                            setState((){
                              debugPrint('Pressing the delete button');
                              _delete();
                            });
                          }
                      )
                  )
                ],
              )
            )

          ],
        ),
      )
    ));
  }

  void moveToLastScreen(){
    Navigator.pop(context, true);
  }

  //update the title of disaster object
  void updateTitle(){
    disaster.title = titleController.text;
  }

  //update the author of disaster object
  void updateDescription(){
    disaster.description = descriptionController.text;
  }

  //save data to database
  void _save() async{

    moveToLastScreen();

    disaster.date = DateFormat.yMMMd().format(DateTime.now());

    int result;
    if(disaster.id!=null){  //update operation
      result = await helper.updatedisaster(disaster);
    }else{ //insert operation
      result = await helper.insertdisaster(disaster);
    }

    if(result!=0){ //success
      _showAlertDialog('Status', 'disaster Saved Successfully');
    }else{ //faliure
      _showAlertDialog('Status', 'Problem saving disaster');
    }
  }

  void _delete() async{

    moveToLastScreen();
    //Case1: if user is trying to delete the new disaster
    if(disaster.id==null){
      _showAlertDialog('Status', 'No disaster was deleted');
      return;
    }

    //case2: if user is trying to delete old disaster
    int result = await helper.deletedisaster(disaster.id);
    if(result != 0){
      _showAlertDialog('Status', 'disaster deleted Successfully');
    }else{
      _showAlertDialog('Staus', 'Error occurred while deleting disaster');
    }
  }

  void _showAlertDialog(String title, String message){
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(
      context: context,
      builder: (_) => alertDialog
    );
  }

}