import 'package:bytebank_salvamento_arquivos/models/Transactions.dart';
import 'package:flutter/material.dart';

class subtitle extends StatelessWidget{
  final Transaction transaction;
  const subtitle({Key? key,required this.transaction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
          text: transaction.contact.name.toString(),
          style: TextStyle(
            fontSize: 16.0,
          ),
          children: <TextSpan>[
            TextSpan(
              text: ' ',
            ),
            TextSpan(
              text: transaction.contact.accountNumber.toString(),
            )
          ]),
    );
  }
}
