import 'package:flutter/material.dart';
import 'package:sqfliteApp/snackbars.dart';
import 'package:sqfliteApp/view_model.dart';

class CreateScreen extends StatefulWidget {
  @override
  _CreateScreenState createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  final vm=view_model();
  void _navigateToCreateScreen() async {
    await vm.navigateToMain(context);
  }

  TextEditingController _nameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

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
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Screen'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Nombre',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: 'Descripción',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                if (_nameController.text.isEmpty || _descriptionController.text.isEmpty) {
                  SnackbarUtils.showErrorSnackbar(
                    context,
                    'Por favor, ingrese un nombre y una descripción',
                  );
                } else {
                  bool insercion = await vm.insertRecord(
                    _nameController.text,
                    _descriptionController.text,
                  );
                  if (insercion) {
                    SnackbarUtils.showCompletedSnackbar(
                      context,
                      'Registro creado correctamente',
                    );
                    _fetchRecords();
                    _navigateToCreateScreen();
                  } else {
                    SnackbarUtils.showErrorSnackbar(
                      context,
                      'Error al crear el registro',
                    );
                  }
                }
              },
              child: Text('Guardar'),
            ),
          ],
        ),
      ),
    );
  }
}
