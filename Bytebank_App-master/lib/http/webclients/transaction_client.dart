import 'package:bytebank_salvamento_arquivos/models/Transactions.dart';
import 'package:bytebank_salvamento_arquivos/models/contact.dart';
import 'package:http/http.dart';
import '../webclient.dart';
import 'dart:convert';

Transaction _toTransaction(Response response) {
  Map<String, dynamic> json = jsonDecode(response.body);
  final Map<String, dynamic> contactJson = json['contact'];
  return Transaction(
    json['value'],
    Contact(
      0,
      contactJson['name'],
      contactJson['accountNumber'],
    ),
  );
}
class TransactionWebClient{

  Future<List<Transaction>> findAll() async {
    final Response response = await client
        .get(Uri.http(baseUrl, 'transactions'))
        .timeout(Duration(seconds: 5));
    List<Transaction> transactions = _toTransactions(response);
    return transactions;
  }

  List<Transaction> _toTransactions(Response response) {
    final List<Transaction> transactions = [];
    final List<dynamic> decodedjson = jsonDecode(response.body);

    for (Map<String, dynamic> transactionJson in decodedjson) {
      // declaração de map => Map<String, dynamic>, mapa de string dinamico
      final Map<String, dynamic> contactJson = transactionJson['contact'];
      final Transaction transaction = Transaction(
        transactionJson['value'],
        Contact(
          0,
          contactJson['name'],
          contactJson['accountNumber'],
        ),
      );
      transactions.add(transaction);
    }
    return transactions;
  }

  Future<Transaction> save(Transaction transaction) async {
    Map<String, dynamic> transactionMap = _toMap(transaction);
    final String TransactionJson = jsonEncode(transactionMap);
    final Response response = await client.post(Uri.http(baseUrl, 'transactions'),
        headers: {
          'Content-type': 'application/json',
          'password': '1000',
        },body:  TransactionJson);
    return _toTransaction(response);
  }

  Map<String, dynamic> _toMap(Transaction transaction) {
     final Map<String, dynamic> transactionMap ={
      'value' : transaction.value,
      'contact' :{
        'name': transaction.contact.name,
        'accountNumber' : transaction.contact.accountNumber,
      }

    };
    return transactionMap;
  }

}
