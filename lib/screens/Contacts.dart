import 'package:bytebank_salvamento_arquivos/components/centered_message.dart';
import 'package:bytebank_salvamento_arquivos/components/progress.dart';
import 'package:bytebank_salvamento_arquivos/components/Textsubtitle.dart';
import 'package:bytebank_salvamento_arquivos/components/Texttitle.dart';
import 'package:bytebank_salvamento_arquivos/http/webclients/transaction_client.dart';
import 'package:bytebank_salvamento_arquivos/models/Transactions.dart';
import 'package:flutter/material.dart';

class TransactionsList extends StatelessWidget {
  final TransactionWebClient _webClient = TransactionWebClient();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transactions'),
      ),
      body: FutureBuilder<List<Transaction>>(
        future: _webClient.findAll(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              if (snapshot.hasData) {
                final List<Transaction>? transactions = snapshot.data;
                if (transactions!.isNotEmpty) {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      final Transaction transaction = transactions[index];
                      return Card(
                        child: ListTile(
                          leading: Icon(Icons.monetization_on),
                          title: title(transaction: transaction,),
                          subtitle: subtitle(transaction: transaction,),
                        ),
                      );
                    },
                    itemCount: transactions.length,
                  );
                }
              }
              break;
            case ConnectionState.none:
              // TODO: Handle this case.
              break;
            case ConnectionState.waiting:
              return Progress();
            case ConnectionState.active:
              // TODO: Handle this case.
              break;
          }
          return CenteredMessage(
            'NO TRANSACTIONS FOUND',
            icon: Icons.warning,
          );
        },
      ),
    );
  }
}
