import 'package:dio/dio.dart';

abstract class INetworkManager {
  Future<Response> get(String path, {Map<String, dynamic>? queryParameters});
  Future<Response> post(String path, {dynamic data});
  Future<Response> put(String path, {dynamic data});
  Future<Response> delete(String path, {dynamic data});
  Future<Response> patch(String path, {dynamic data});
}