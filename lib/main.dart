import 'package:bytebank_salvamento_arquivos/screens/dashboard.dart';
import 'package:flutter/material.dart';

import 'components/transaction_auth_dialog.dart';


void main() {
  runApp(bytebank());
  //save(Transaction(200.0,Contact(0, 'Hugo',2000))).then((transaction) => print(transaction));
  //findAll().then((transactions) => print('new transactions $transactions'));
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
