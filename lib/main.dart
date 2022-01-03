import 'package:bytebank_salvamento_arquivos/screens/dashboard.dart';
import 'package:flutter/material.dart';

import 'http/webclient.dart';

void main() {
  runApp(bytebank());
  findAll();
}

class bytebank extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.green.shade900,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Colors.green.shade900,
          secondary: Colors.blueAccent.shade700,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(Colors.blueAccent.shade700),
          ),
        ),
      ),
      home: Dashboard(),
    );
  }
}
