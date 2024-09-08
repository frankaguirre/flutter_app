import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Asegúrate de que esto esté en el pubspec.yaml

import 'wiggets/aportes.dart';
import 'wiggets/login_page.dart'; // Asegúrate de que la ruta sea correcta


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AportesProvider(),
      child: MaterialApp(
        home: LoginPage(), // Cambia esto si tienes una página de inicio diferente
      ),
    );
  }
}
