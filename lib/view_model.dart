import 'package:flutter/material.dart';
import 'create_screen.dart';
import 'database_helper.dart';
import 'edit_screen.dart';
import 'main.dart';

class view_model {
  final dbHelper = DatabaseHelper();

  void showSnackBar(String message, context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }

  Future<bool> insertRecord(String name, String description) async {
    
    Map<String, dynamic> row = {
      'name': name,
      'description': description,
    };

    int id = await dbHelper.insert(row);
    if (id != 0) {      
      return true;
    } else {      
      return false;
    }
  }

  Future<bool> updateRecord(int id, String name, String description) async {
    
    Map<String, dynamic> row = {
      'id': id,
      'name': name,
      'description': description,
    };

    int count = await dbHelper.update(row);
    if (count != 0) {      
      return true;
    } else {      
      return false;
    }
    
  }

  Future<bool> deleteRecord(int id) async {
    int count = await dbHelper.delete(id);
    if (count != 0) {      
      return true;
    } else {      
      return false;
    }    
  }

  Future<List<Map<String, dynamic>>> fetch() async{
    return await dbHelper.queryAll();
  }


  Future<Map<String, dynamic>?> _navigateToEditScreen(BuildContext context, Map<String, dynamic> record) async {
    return await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditScreen(record: record),
      ),
    );
  }


  //metodo futuro para navegar a la pantalla de creacion


  Future<void> navigateToCreateScreen(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreateScreen(),
      ),
    );
  }

  //metodo futuro para navegar a la pantalla de main
Future<void> navigateToMain(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MyApp(),
      ),
    );
  }

  //Metodo futuro para navegar a la pantalla de edit_screen
  Future<void> navigateToEditScreen(BuildContext context, Map<String, dynamic> record) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditScreen(record: record),
      ),
    );
  }



}
