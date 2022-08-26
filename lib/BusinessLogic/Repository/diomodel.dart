import 'package:dio/dio.dart';

class DioModel {
  /*requestType = {
    'get',
    'post',
    'put',
    'delete',
    'head',
    'put',
    'path',
    'download'
  };*/
  final String requestType;
  final String query;
  Map<String, dynamic>? parameters;
  Options? options; //=[,];
  DioModel(
      {required this.query,
      required this.requestType,
      this.parameters,
      this.options});

  Future<Response> dioQuery() async {
    Dio dio = Dio();
    late final Response response;
    switch (requestType) {
      case 'get':
        response =
            await dio.get(query, queryParameters: parameters, options: options);
        break;
      case 'post':
        response = await dio.post(query,
            queryParameters: parameters, options: options);
        break;
      case 'put':
        response =
            await dio.put(query, queryParameters: parameters, options: options);
        break;
      case 'delete':
        response = await dio.delete(query,
            queryParameters: parameters, options: options);
        break;
      case 'head':
        response = await dio.head(query,
            queryParameters: parameters, options: options);
        break;
      case 'patch':
        response = await dio.patch(query,
            queryParameters: parameters, options: options);
        break;
      default:
        response =
            await dio.get(query, queryParameters: parameters, options: options);
        break;
    }
    return response;
  }
}
