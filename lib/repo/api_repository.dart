import 'package:dio/dio.dart';
import 'package:zmare/modals/exception.dart';
import 'package:zmare/repo/repository.dart';
import 'package:zmare/service/api_client.dart';
import 'package:zmare/utils/extension.dart';

class ApiRepository<T> extends IRepositroy<T> {
  final dioClient = ApiClient.getDioInstance();
  @override
  Future<R> create<R, S>(String path, S body,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      var result = await dioClient.post<R>(path,
          data: body, queryParameters: queryParameters);
      var finalResult = result.data.toObject(R.toString());
      print(finalResult);
      return finalResult as R;
    } on DioError catch (ex) {
      print(ex);
      return Future.error(AppException.handleerror(ex));
    }
  }

  @override
  Future<bool> delete(String path, {Map<String, dynamic>? queryParameters}) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<R?> get<R>(String path,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      var result = await dioClient.get(path, queryParameters: queryParameters);

      var mapResult = result.data as Map<String, dynamic>;
      print(result.data);
      var finalResult = await mapResult.toObject(R.toString());
      return finalResult as R?;
    } on DioError catch (ex) {
      print(ex.toString());
      return Future.error(AppException.handleerror(ex));
    }
  }

  @override
  Future<List<R>> getAll<R>(String path,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      // var result =  apiClient.get(path)
      var response =
          await dioClient.get(path, queryParameters: queryParameters);
      var conversionResult = response.data as List<dynamic>;
      var finalResult = conversionResult.map((element) {
        var newElement = element as Map<String, dynamic>;
        return newElement.toObject(R.toString()) as R;
      }).toList();
      print(finalResult);

      return finalResult;
    } on DioError catch (e) {
      print(e);
      return Future.error(AppException.handleerror(e));
    }
  }

  @override
  Future<R> update<R, S>(String path,
      {S? body, Map<String, dynamic>? queryParameters}) async {
    try {
      var result = await dioClient.put(path,
          data: body, queryParameters: queryParameters);
      print(result.data);

      var mapResult = result.data as bool;
      // var finalResult = await mapResult.toObject(S.toString());
      return mapResult as R;
    } on DioError catch (ex) {
      print(ex.toString());
      return Future.error(AppException.handleerror(ex));
    }
  }
}
