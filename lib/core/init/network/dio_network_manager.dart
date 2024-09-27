import 'package:dio/dio.dart';
import 'package:pdv_windows/core/init/network/INetworkManager.dart';
import 'package:pdv_windows/core/init/network/dio_error_manager.dart';

class DioNetworkManager extends INetworkManager {

  final Dio _dio;

  DioNetworkManager({
    required String baseUrl,
    Map<String, dynamic>? headers,
  }) : _dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      headers: headers,
    ),
  );

  @override
  Future<Response> get(String path, {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.get(path, queryParameters: queryParameters);
      return response;
    } on DioException catch (e) {
      throw DioErrorManager.handleError(e);
    }
  }

  @override
  Future<Response> post(String path, {dynamic data, Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.post(path, data: data,queryParameters: queryParameters);
      return response;
    } on DioException catch (e) {
      throw DioErrorManager.handleError(e);
    }
  }

  @override
  Future<Response> put(String path, {dynamic data,Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.put(path, data: data,queryParameters: queryParameters);
      return response;
    } on DioException catch (e) {
      throw DioErrorManager.handleError(e);
    }
  }

  @override
  Future<Response> delete(String path, {dynamic data,Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.delete(path, data: data,queryParameters: queryParameters);
      return response;
    } on DioException catch (e) {
      throw DioErrorManager.handleError(e);
    }
  }

  @override
  Future<Response> patch(String path, {dynamic data,Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.patch(path, data: data,queryParameters: queryParameters);
      return response;
    } on DioException catch (e) {
      throw DioErrorManager.handleError(e);
    }
  }
}