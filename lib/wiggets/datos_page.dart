import 'package:flutter/material.dart';

class DatosAmbientalesPage extends StatefulWidget {
  @override
  _DatosAmbientalesPageState createState() => _DatosAmbientalesPageState();
}

class _DatosAmbientalesPageState extends State<DatosAmbientalesPage> {
  List<String> acciones = [
    'Reducir la huella de carbono',
    'Conservación del agua',
    'Energías renovables',
    'Protección de la biodiversidad',
    'Reciclaje y gestión de residuos',
    'Reforestación y restauración ecológica',
  ];

  List<String> seleccionadas = [];

  void _toggleAccion(String accion) {
    setState(() {
      if (seleccionadas.contains(accion)) {
        seleccionadas.remove(accion);
      } else if (seleccionadas.length < 3) {
        seleccionadas.add(accion);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Solo puedes seleccionar hasta 3 acciones.')),
        );
      }
    });
  }

  void _motivar(String accion) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Motivación Ambiental'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Acción: "$accion"',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                SizedBox(height: 10),
                Text(
                  'La acción "$accion" tiene un impacto significativo en nuestro entorno. '
                  'Reducir la huella de carbono implica adoptar prácticas que disminuyan la cantidad de gases de efecto invernadero que liberamos a la atmósfera. '
                  'Esto puede incluir el uso de transporte público, reducir el consumo de energía y optar por productos sostenibles. '
                  'Cada pequeña acción cuenta y ayuda a mitigar los efectos del cambio climático. ¡Tu esfuerzo puede inspirar a otros a unirse a esta causa vital! '
                  'No subestimes el poder de tus acciones para hacer una diferencia positiva en nuestro planeta.',
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text('Cerrar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _reforestar(String accion) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Reforestación en marcha'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Acción: "$accion"',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                SizedBox(height: 10),
                Text(
                  'La reforestación es una de las formas más efectivas de combatir el cambio climático y restaurar ecosistemas dañados. '
                  'La acción "$accion" se enfoca en plantar árboles en áreas deforestadas o degradadas para recuperar la cubierta vegetal. '
                  'Esto ayuda a absorber dióxido de carbono, mejorar la calidad del aire y el agua, y proporcionar hábitats para la vida silvestre. '
                  'Además, la reforestación contribuye a la protección del suelo contra la erosión y apoya la biodiversidad local. '
                  'Participar en iniciativas de reforestación no solo es beneficioso para el medio ambiente, sino que también promueve un sentido de comunidad y colaboración. ¡Un gran paso hacia un futuro más verde!',
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text('Cerrar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Acciones Ambientales'),
        backgroundColor: Colors.green[700],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.75,
          ),
          itemCount: acciones.length,
          itemBuilder: (context, index) {
            final accion = acciones[index];
            final isSelected = seleccionadas.contains(accion);
            return GestureDetector(
              onTap: () => _toggleAccion(accion),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                color: isSelected ? Colors.lightGreenAccent : Colors.white,
                elevation: 5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.eco,
                      size: 80,
                      color: Colors.green,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        accion,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: isSelected ? Colors.green[900] : Colors.black,
                        ),
                      ),
                    ),
                    if (isSelected)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              onPressed: () => _motivar(accion),
                              child: Text('Motivar'),
                              style: ElevatedButton.styleFrom(
                                primary: Colors.green[600],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () => _reforestar(accion),
                              child: Text('Reforestar'),
                              style: ElevatedButton.styleFrom(
                                primary: Colors.brown,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: null, // Elimina el botón flotante
    );
  }
}
