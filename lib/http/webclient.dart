import 'dart:convert';
import 'package:bytebank_salvamento_arquivos/models/Transactions.dart';
import 'package:bytebank_salvamento_arquivos/models/contact.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';

class LoggingInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    print('Request');
    print('url: ${data.url}');
    print('headers: ${data.headers}');
    print('body: ${data.body}');
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    print('Response');
    print('Status Code: ${data.statusCode}');
    print('headers: ${data.headers}');
    print('body: ${data.body}');
    return data;
  }
}

final Client client = InterceptedClient.build(
  //interptador a nivel de arquivo para ser usado em qualquer chamada
  interceptors: [LoggingInterceptor()],
);

const String baseUrl = '192.168.1.109:8080'; //'transactions';
Future<List<Transaction>> findAll() async {
  final Response response = await client
      .get(Uri.http(baseUrl, 'transactions'))
      .timeout(Duration(seconds: 5));
  final List<dynamic> decodedjson = jsonDecode(response.body);
  final List<Transaction> transactions = [];
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

void save(Transaction transaction) async {
  final Map<String, dynamic> transactionMap ={
    'value' : transaction.value,
    'contact' :{
      'name': transaction.contact.name,
      'accountNumber' : transaction.contact.accountNumber,
    }

  };
  final String TransactionJson = jsonEncode(transactionMap);
  final Response response = await client.post(Uri.http(baseUrl, 'transactions'),
      headers: {
        'Content-type': 'application/json',
        'password': '1000',
      },body:  TransactionJson);
}
