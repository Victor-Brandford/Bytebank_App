import 'package:flutter/material.dart';

class TransactionAuthDialog  extends StatefulWidget {
  final Function(String) onConfirm;

  TransactionAuthDialog({required this.onConfirm});

  @override
  State<TransactionAuthDialog> createState() => _TransactionAuthDialogState();
}

class _TransactionAuthDialogState extends State<TransactionAuthDialog> {
  final TextEditingController _passwordControler = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Authenticate'),
      content: TextField(
        controller: _passwordControler,
        obscureText: true,
        maxLength: 4,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
        ),
        style: TextStyle(
          fontSize: 64,
          letterSpacing: 24,
        ),
      ),
      actions: <Widget>[
        FlatButton(onPressed: () { print('cancel');}, child: Text('cancel'),),
        FlatButton(onPressed: () { print('confirm');}, child: Text('confirm'),),
      ],
    );
  }
}
