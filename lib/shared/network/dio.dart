//http://192.168.43.26:8000/api/
//String token=CacheHelper.getStringData(key: token)==null?' ':CacheHelper.getStringData(key: token) ;
//String token=CacheHelper.getStringData(key: 'token')!=null ? ' ':CacheHelper.getStringData(key: 'token');

import 'dart:io';

import 'package:EZ_Shop/shared/helperFunctions.dart';
import 'package:EZ_Shop/shared/sharedPreferences.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

String baseUrl = 'http://192.168.105.247:8000/';
String TOKEN =CacheHelper.getStringData(key: 'token')??'';
class dioHelper {
  static late Dio dio;
  static Map<String, dynamic> headers = {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $TOKEN}',
  };

  // Authorization
  static init() {
    print('iniiii');
    dio = Dio(
        BaseOptions(
        baseUrl:baseUrl,
        receiveDataWhenStatusError: true,
        headers: headers,
        validateStatus: (status) {
          return true;
        }));
  }

  static Future<dynamic> getData({required String url,
      dynamic query, dynamic data }) async {
    TOKEN =CacheHelper.getStringData(key: 'token');
    late Response response;
    try {
      dio.options.headers['Authorization']='Bearer ' + TOKEN;
      response = await dio.get(
        baseUrl + url,
        queryParameters: query,
      );
      Logger().d('URL : '+
          baseUrl + url+ '\n'+
          'query : '+
          query.toString() + '\n'+
          'BODY : '+
          data.toString() + '\n'+
          'RESPONSE : '+
          response.toString() + '\nToken ' + TOKEN);
     }
      on SocketException {
      toast('Internet Connection Error!');
      Logger().e('SocketException');
    } catch (e) {
      toast('Internet Connection Error!');

      Logger().e(e);
    }
    if(response.statusCode==200||response.statusCode==201)
    return response.data;
  }

  static Future<dynamic> postData({required String url,
      dynamic query,
      dynamic data}) async {
    var response;
    print('test');
    print(TOKEN);
    try {
       response = await dio.post(
        url,
        queryParameters: query,
        data: data,
      );
      Logger().d('URL : '+
          baseUrl + url+ '\n'+
          'RESPONSE : '+
          response.toString());

    } on SocketException {
      toast('Internet Connection Error!');

      Logger().e('SocketException');
    } catch (e) {
      Logger().e(e);
    }
    headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${CacheHelper.getStringData(key: 'token')}',
    };
    return response;
  }

  static Future<dynamic> deleteData({required String url ,dynamic query,
  dynamic data}) async {
    var response;
    try {
      response = await dio.delete(
        url, queryParameters: query,
        data: data,
      );
      Logger().d('URL : ' +
          baseUrl +
          url +
          '\n' +
          'RESPONSE : ' +
          response.toString());
    } on SocketException {
      Logger().e('SocketException');
    } catch (e) {
      Logger().e(e);
    }
    return response;
  }

  static Future<Response> putData({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic>? data,
  }) async {
    print(baseUrl+url);
    return await dio.put(
      url,
      queryParameters: query,
      data: data,
    );
  }

  static Future<Response> postFormData({
    required String url,
    Map<String, dynamic>? query,
    formData,
  }) async {
    print(baseUrl+url);
    print(url);
    return await dio.post(url, data: formData);
  }
}