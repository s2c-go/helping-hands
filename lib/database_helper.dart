import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'disaster.dart';

class DatabaseHelper{
  static DatabaseHelper _databaseHelper; //singleton database helper
  static Database _database;
  String disasterTable = 'disaster_table';
  String colId= 'id';
  String colTitle = 'title';
  String colDescription = 'description';
  String colDate = 'date';

  DatabaseHelper._createInstance(); //named constructor to create instance of database helper

  factory DatabaseHelper(){

    if(_databaseHelper==null) {
      _databaseHelper = DatabaseHelper._createInstance(); //this is executed only once, singleton object
    }

    return _databaseHelper;
  }

  Future<Database> get database async{

    if(_database == null){
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async{
    //get the directory path for both android and ios to store database.
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'disaster.db';

    //open/create database at a given path
    var disastersDatabase = await openDatabase(path, version: 1, onCreate: _createDb);
    return disastersDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute('CREATE TABLE $disasterTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colTitle TEXT,'
        '$colDescription TEXT, $colDate TEXT)');
  }

  //fetch operation: get all disaster objects from database
  Future<List<Map<String, dynamic>>> getdisastersMapList() async{
    Database db = await this.database;

    var result = await db.rawQuery('SELECT * FROM $disasterTable');
    return result;
  }
  //insert operation: insert a new disaster object to database
  Future<int> insertdisaster(Disaster disaster) async{
    Database db = await this.database;
    var result = await db.insert(disasterTable, disaster.toMap());
    return result;
  }

  //update operation: update a disaster object and save it to database
  Future<int> updatedisaster(Disaster disaster) async{
    var db = await this.database;
    var result =  await db.update(disasterTable, disaster.toMap(), where: '$colId = ?', whereArgs: [disaster.id]);
    return result;
  }

  //delete operation : delete a disaster object from database
  Future<int> deletedisaster(int id) async {
    var db = await this.database;
    int result = await db.rawDelete('DELETE FROM $disasterTable WHERE $colId = $id');
    return result;
  }

  //get number of disaster objects in database
  Future<int> getCount() async{
    Database db = await this.database;
    List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT (*) from $disasterTable');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  //get the map list and convert it to disaster list
  Future<List<Disaster>> getdisasterList() async{
    var disasterMapList = await getdisastersMapList(); //get map list from database
    int count = disasterMapList.length; //count the no. of map entries in db table

    List<Disaster> disasterList = List<Disaster>();

    for(int i=0;i< count; i++){
      disasterList.add(Disaster.fromMapObject(disasterMapList[i]));
    }

    return disasterList;
  }
}