import 'package:flutter/material.dart';
import 'package:flutter_application_10/wiggets/home-page2.dart';
import 'page1.dart';
import 'page2.dart';
import 'page3.dart';
import 'page4.dart';
import 'package:flutter_application_10/wiggets/aportes.dart'; 

class HomePage1 extends StatelessWidget {
  void _navigateToPage(BuildContext context, int index) {
    switch (index) {
      case 1:
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => Page1()));
        break;
      case 2:
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => Page2()));
        break;
      case 3:
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => Page3()));
        break;
      case 4:
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => Page4()));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      appBar: AppBar(
        title: Text(
          'Conciencia Ambiental',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green[700],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 1.0),
            child: Text(
              'Nuestro entorno enfrenta grandes desafíos debido a las actividades humanas. Aquí te presentamos cuatro acciones clave para contribuir a un futuro más sostenible:\n\n'
              '• Recolección de residuos: Mejora la gestión y clasificación de residuos para reducir la contaminación y promover la reutilización.\n\n'
              '• Reciclaje: Transforma materiales usados en nuevos productos, conservando recursos naturales y reduciendo desechos.\n\n'
              '• Reforestación: Ayuda a restaurar ecosistemas y combate el cambio climático plantando árboles.\n\n'
              '• Motivación y educación ambiental: Inspira a otros a adoptar prácticas sostenibles mediante la difusión de información ambiental.\n\n'
              'Selecciona una acción y únete al esfuerzo para hacer una diferencia positiva en nuestro planeta. ¡Tu participación es esencial!',
              style: TextStyle(fontSize: 14),
            ),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              itemCount: 4,
              itemBuilder: (context, index) {
                final titles = ['2-Reciclaje', '1-Recolecion', '3-Reforestar', '4-Motivar'];
                return GestureDetector(
                  onTap: () => _navigateToPage(context, index + 1),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.green[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        titles[index],
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed: () {
                // Redirigir a HomePage2
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomePage2()));
              },
              child: Text('Ver más información'),
            ),
          ),
        ],
      ),
    );
  }
}



