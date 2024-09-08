import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'aportes.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final aportesProvider = Provider.of<AportesProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Información'),
        backgroundColor: Colors.green[700],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: double.infinity,
            color: Colors.green[700],
            padding: EdgeInsets.all(16),
            child: Text(
              '¡Gracias por tu participación!',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
          SizedBox(height: 20),
          Center(
            child: Image.asset('assets/image/a.png', width: 400, height: 150),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Objetivo de la aplicación: fomentar la conciencia ambiental a través de acciones diarias.'
              "La Tierra no es una herencia de nuestros padres, sino un préstamo de nuestros hijos. Cada acción que tomamos, cada decisión que hacemos, afecta no solo nuestro presente, sino el futuro de las generaciones venideras. No podemos esperar a que otros actúen; debemos ser nosotros los que lideremos con el ejemplo. En nuestras manos está el poder de transformar nuestro entorno y garantizar un planeta saludable para todos. El cambio comienza con cada uno de nosotros. ¡Actúa ahora, por ti y por todos!"

              "— David Attenborough"
              ,
              style: TextStyle(fontSize: 16),
            ),
          ),
          SizedBox(height: 20),
          Divider(),
          SizedBox(height: 10),
          Text(
            'Total de aportes realizados: ${aportesProvider.aportes}',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FaIcon(FontAwesomeIcons.facebook, size: 30, color: Colors.blue),
              SizedBox(width: 20),
              FaIcon(FontAwesomeIcons.twitter, size: 30, color: Colors.blue),
              SizedBox(width: 20),
              FaIcon(FontAwesomeIcons.instagram, size: 30, color: Colors.purple),
            ],
          ),
        ],
      ),
    );
  }
}
