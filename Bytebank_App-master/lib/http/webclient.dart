
import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'interceptors/logging_interceptor.dart';

final Client client = InterceptedClient.build(
  //interptador a nivel de arquivo para ser usado em qualquer chamada
  interceptors: [LoggingInterceptor()],
);

const String baseUrl = '192.168.1.109:8080'; //'transactions';