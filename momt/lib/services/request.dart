import 'dart:io';

import 'package:dio/dio.dart';


class Request {
  static final Dio http = _initializeAndGetRequestor();

  static Dio _initializeAndGetRequestor() {
    BaseOptions options = new BaseOptions(
        connectTimeout: 5000,
        receiveTimeout: 5000,
        headers: {HttpHeaders.contentTypeHeader: 'application/json'});
    return Dio(options);
  }

  static Future<Options> _getOptions(Map<String, String> headers) async {


    // headers.update():
    return Options(
      headers: headers,
    );
  }

  static Future<Map<String, dynamic>> post(
      String url, Map<String, String> header, Map data) async {
    final response =
        await http.post(url, options: await _getOptions(header), data: data);
    return response.data;
  }


  static Future<Map<String, dynamic>> get(
      String url, Map<String, String> header) async {
    final response = await http.get(url, options: await _getOptions(header));
    return response.data;
  }

  static Future<Map<String, dynamic>> delete(
      String url, Map<String, String> header) async {
    final response = await http.delete(url, options: await _getOptions(header));

    return response.data;
  }
}
