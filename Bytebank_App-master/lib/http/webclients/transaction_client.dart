import 'package:bytebank_salvamento_arquivos/models/Transactions.dart';
import 'package:http/http.dart';
import '../webclient.dart';
import 'dart:convert';

class TransactionWebClient{
  Future<List<Transaction>> findAll() async {
    final Response response =
    await client.get(Uri.http(baseUrl, 'transactions')).timeout(Duration(seconds: 5));
    final List<dynamic> decodedJson = jsonDecode(response.body);
    return decodedJson
        .map((dynamic json) => Transaction.fromJson(json))
        .toList();
  }
  Future<Transaction> save(Transaction transaction) async {
    final String TransactionJson = jsonEncode(transaction.toJson());
    final Response response = await client.post(Uri.http(baseUrl, 'transactions'),
        headers: {
          'Content-type': 'application/json',
          'password': '1000',
        },body:  TransactionJson);
    return Transaction.fromJson(jsonDecode(response.body));
  }
}
