import 'package:bytebank_salvamento_arquivos/models/Transactions.dart';
import 'package:flutter/material.dart';

class title extends StatelessWidget {
  final Transaction transaction;
  const title({Key? key, required this.transaction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      transaction.value.toString(),
      style: TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
