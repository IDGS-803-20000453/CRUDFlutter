import 'package:flutter/material.dart';
import 'package:sqfliteApp/view_model.dart';

import 'alertas.dart';
import 'snackbars.dart';
//import 'database_helper.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CRUD con SQLite',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  //final dbHelper = DatabaseHelper();
  final vm=view_model();
  void _navigateToCreateScreen() async {
    await vm.navigateToCreateScreen(context);
  }
  void _navigateToEditScreen(Map<String, dynamic> record) async {
    await vm.navigateToEditScreen(context, record);
  }

  List<Map<String, dynamic>> _records = [];
  TextEditingController _nameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _nameControllerNew = TextEditingController();
  TextEditingController _descriptionControllerNew = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchRecords();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _fetchRecords() async {
    List<Map<String, dynamic>> records = await vm.fetch();
    setState(() {
      _nameController.clear();
      _descriptionController.clear();
      _records = records;
    });
  }

  void _selectRecord(Map<String, dynamic> record) {
    _nameController.text = record['name'];
    _descriptionController.text = record['description'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CRUD con SQLite'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: Colors.grey[200],
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      'Nombre: ',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        controller: _nameController,
                        enabled: false,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(vertical: 4.0),
                          hintText: 'Ingrese el nombre',
                          hintStyle: TextStyle(fontSize: 18.0),
                        ),
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8.0),
              Container(
                color: Colors.grey[200],
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      'Descripción: ',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        controller: _descriptionController,
                        enabled: false,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(vertical: 4.0),
                          hintText: 'Ingrese la descripción',
                          hintStyle: TextStyle(fontSize: 18.0),
                        ),
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.0),
              Row(
                children: [

                ],
              ),
            ],
          ),

            /*TextField(
              controller: _nameControllerNew,
              decoration: InputDecoration(
                labelText: 'Nuevo Nombre',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _descriptionControllerNew,
              decoration: InputDecoration(
                labelText: 'Nueva Descripción',
              ),
            ),

             */
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_nameController.text.isEmpty ||
                          _descriptionController.text.isEmpty) {
                        SnackbarUtils.showErrorSnackbar(
                          context,
                          'Por favor, Seleccione un registro',
                        );
                      } else if (_records.isNotEmpty) {
                        _navigateToEditScreen(_records.firstWhere(
                              (record) =>
                          record['name'] == _nameController.text &&
                              record['description'] == _descriptionController.text,
                          orElse: () => {},
                        ));
                      } else {
                        SnackbarUtils.showErrorSnackbar(
                          context,
                          'No hay registros disponibles',
                        );
                      }

                      /*
                      Map<String, dynamic>? selectedRecord;

                      if (_records.isNotEmpty) {
                        Map<String, dynamic> selectedRecord =
                        _records.firstWhere(
                              (record) =>
                          record['name'] == _nameController.text &&
                              record['description'] == _descriptionController.text,
                          orElse: () => {},
                        );
                        if (selectedRecord.isNotEmpty) {
                          bool actualizacion = await vm.updateRecord(
                              selectedRecord['id'],
                              _nameControllerNew.text,
                              _descriptionControllerNew.text);
                          if (actualizacion) {
                            vm.showSnackBar(
                                'Registro actualizado correctamente', context);
                            _fetchRecords(); // Actualizar la lista de registros
                          } else {
                            vm.showSnackBar('Error al actualizar el registro', context);
                          }
                        } else {
                          vm.showSnackBar(
                              'No se encontró el registro seleccionado', context);
                        }
                      } else {
                        vm.showSnackBar('No hay registros disponibles', context);
                      }

                       */
                    },
                    child: Text('Actualizar'),
                  ),

                ),
                SizedBox(width: 16.0),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_records.isNotEmpty) {
                        Map<String, dynamic> selectedRecord =
                        _records.firstWhere(
                              (record) =>
                          record['name'] == _nameController.text &&
                              record['description'] == _descriptionController.text,
                          orElse: () => {},
                        );
                        if (selectedRecord.isNotEmpty) {
                          AlertUtils.showDeleteConfirmation(context, () {
                            vm.deleteRecord(selectedRecord['id']);
                            _fetchRecords();
                            SnackbarUtils.showCompletedSnackbar(
                                context, 'Registro eliminado correctamente');
                          });
                        } else {
                          SnackbarUtils.showErrorSnackbar(
                              context, 'No se encontró el registro seleccionado');
                        }
                      } else {
                        SnackbarUtils.showErrorSnackbar(
                            context, 'No hay registros disponibles');
                      }
                    },
                    child: Text('Eliminar'),
                  ),
                ),

              ],
            ),
            SizedBox(height: 16.0),
            Text(
              'Registros:',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Expanded(
              child: ListView.builder(
                itemCount: _records.length,
                itemBuilder: (BuildContext context, int index) {
                  Map<String, dynamic> record = _records[index];
                  return Card (
                    child: ListTile(
                      title: Text(record['name']),
                      subtitle: Text(record['description']),
                      onTap: () {
                        _selectRecord(record);
                      },
                    ),);
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToCreateScreen,
        child: Icon(Icons.add),
      ),

    );
  }
}