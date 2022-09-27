import 'package:dio/dio.dart';
import 'package:zema/modals/exception.dart';
import 'package:zema/repo/repository.dart';
import 'package:zema/service/api_client.dart';
import 'package:zema/utils/extension.dart';

class ApiRepository<T> extends IRepositroy<T> {
  final dioClient = ApiClient.getDioInstance();
  @override
  Future<R> create<R>(String path, T body,
      {Map<String, dynamic>? queryParameters}) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<bool> delete(String path, {Map<String, dynamic>? queryParameters}) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<T?> get(String path, {Map<String, dynamic>? queryParameters}) async {
    try {
      var result = await dioClient.get(path, queryParameters: queryParameters);
      print(result.data);

      var mapResult = result.data as Map<String, dynamic>;
      var finalResult = await mapResult.toObject(T.toString());
      return finalResult as T?;
    } on DioError catch (ex) {
      print(ex.toString());
      return Future.error(AppException.handleerror(ex));
    }
  }

  @override
  Future<List<T>> getAll(String path, {Map<String, dynamic>? queryParameters}) {
    // TODO: implement getAll
    throw UnimplementedError();
  }

  @override
  Future<R> update<R>(String path, T? body,
      {Map<String, dynamic>? queryParameters}) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
