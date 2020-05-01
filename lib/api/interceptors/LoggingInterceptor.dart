import 'package:http_interceptor/http_interceptor.dart';

class LoggingInterceptor extends InterceptorContract {
  @override
  Future<RequestData> interceptRequest({RequestData data}) async {
    // print('Request');
    // print('url: ${data.url}');
    // print('headers: ${data.headers}');
    // print('body: ${data.body}');
    // print('--------------------');
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({ResponseData data}) async {
    // print('Response');
    // print('status: ${data.statusCode}');
    // print('headers: ${data.headers}');
    // print('body: ${data.body}');
    // print('--------------------');
    return data;
  }
}