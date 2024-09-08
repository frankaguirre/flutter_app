import 'package:flutter/material.dart';

class AgregarAmbientalPage extends StatefulWidget {
  @override
  _AgregarAmbientalPageState createState() => _AgregarAmbientalPageState();
}

class _AgregarAmbientalPageState extends State<AgregarAmbientalPage> {
  final _formKey = GlobalKey<FormState>();
  String nuevaAccion = '';

  void _guardarAccion() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Navigator.of(context).pop(nuevaAccion);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar Acción Ambiental'),
        backgroundColor: Colors.green[700], // Verde oscuro en el AppBar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Nueva Acción Ambiental',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa una acción ambiental';
                  }
                  return null;
                },
                onSaved: (value) {
                  nuevaAccion = value!;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _guardarAccion,
                child: Text('Guardar Acción'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.green[700], // Verde en el botón
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
