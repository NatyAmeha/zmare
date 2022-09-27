abstract class IRepositroy<T> {
  Future<List<T>> getAll(String path, {Map<String, dynamic>? queryParameters});

  Future<T?> get(String path, {Map<String, dynamic>? queryParameters});

  Future<R> create<R>(String path, T body,
      {Map<String, dynamic>? queryParameters});

  Future<R> update<R>(String path, T? body,
      {Map<String, dynamic>? queryParameters});

  Future<bool> delete(String path, {Map<String, dynamic>? queryParameters});
}
