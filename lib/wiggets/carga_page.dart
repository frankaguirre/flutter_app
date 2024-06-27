import 'package:flutter/material.dart';

class CargaPage extends StatelessWidget {
  const CargaPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator());
  }
}