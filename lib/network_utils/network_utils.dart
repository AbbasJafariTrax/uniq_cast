import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:uniq_cast_test/General/constants.dart';
import 'package:uniq_cast_test/General/my_shared_prefs.dart';
import 'package:uniq_cast_test/models/api_response.dart';
import 'package:uniq_cast_test/network_utils/url_apis.dart';

class NetworkUtils {
  BaseOptions options = new BaseOptions(
    baseUrl: UrlAPIs.baseUrl,
    connectTimeout: 100000,
    receiveTimeout: 120000,
  );
  late Dio _dio;

  NetworkUtils() {
    _dio = new Dio(options);
  }

  Future<dynamic> post(String url, Map<String, dynamic> dataMap,
      {bool isFormData = false}) async {
    try {
      Response res;
      Map<String, dynamic> req_hearders = await this._genHeaders();
      res = await _dio.post(
        url,
        data: isFormData ? FormData.fromMap(dataMap) : dataMap,
        options: Options(
          headers: req_hearders,
        ),
      );
      if (res.statusCode == 200) {
        return ApiResponse(true, "Success", res);
      } else if (res.statusCode == 403) {
        return ApiResponse(
            false, res.statusMessage ?? "Identifier or password invalid.", res);
      }
    } on SocketException catch (e) {
      return ApiResponse(false, ConstantMessage.internetErrMsg, {});
    } catch (e) {
      return ApiResponse(false, "Identifier or password invalid.", {});
    }
  }

  Future<dynamic> get(String url) async {
    try {
      Response res;
      Map<String, dynamic> req_hearders = await this._genHeaders();
      res = await _dio.get(
        url,
        options: Options(
          headers: req_hearders,
        ),
      );

      return ApiResponse(true, "Success", res);
    } on SocketException catch (_) {
      return ApiResponse(false, ConstantMessage.internetErrMsg, {});
    } catch (e) {
      return ApiResponse(false, ConstantMessage.unknownErrMsg, {});
    }
  }

  Future<Map<String, dynamic>> _genHeaders() async {
    String token = await SharedPrefs.getToken();

    Map<String, dynamic> headers = {};

    if (token != null && token != "") {
      headers.addAll({'Authorization': 'Bearer ' + token});
    }

    return headers;
  }
}
