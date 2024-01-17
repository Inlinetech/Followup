import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart' as Getx;
import 'package:inquiryapp/common/app_routes.dart';
import 'package:inquiryapp/common/network/api_manager/api_urls_endpoints.dart';
import 'package:inquiryapp/common/shared_pref_helper.dart';
import 'package:inquiryapp/common/utillity_helper.dart';

class DioClient {
// dio instance
  final Dio _dio;

  DioClient(this._dio) {
    _dio
      ..options.baseUrl = APIEndPoints.baseUrl
      ..options.connectTimeout = APIEndPoints.connectionTimeout
      ..options.receiveTimeout = APIEndPoints.receiveTimeout
      ..options.contentType = Headers.formUrlEncodedContentType
      ..options.validateStatus = (status) => true;

      // ..options.responseType = ResponseType.json;
  }

  // Get:-----------------------------------------------------------------------
  Future<Response> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      if (kDebugMode) {
        print("--------------URL----------------\n ${APIEndPoints.baseUrl + url}",);
        print("---------------------------------");
      }

      if (kDebugMode) {
        print("-----------Params-------------\n $queryParameters",);
        print("------------------------------");
      }
      final Response response = await _dio.get(
        url,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      if (kDebugMode) {
        print("-----------Response-------------\n $response",);
        print("--------------------------------");
      }

      if (response.statusCode == 401) {
        Map<String, dynamic> jsonData = json.decode(response.data);
        UtilityHelper.instance.showError("Error", jsonData['errors']);
        await SharedPref.save("user", null);
        Getx.Get.toNamed(AppRoutes.signin);
      }
      return response;
    } catch (e) {
      if (kDebugMode) {
        print("-----------Error-------------\n $e");
        print("-----------------------------");
      }
      rethrow;
    }
  }

  // Post:----------------------------------------------------------------------
  Future<Response> post(
    String url, {
    data, isCommonParamsAdd = false,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      if (kDebugMode) {
        print("--------------URL----------------\n ${APIEndPoints.baseUrl + url}",);
        print("---------------------------------");
      }

      if (isCommonParamsAdd) {
        await commonParameters(data);
      }

      if (kDebugMode) {
        print("-----------Params-------------\n $data",);
        print("------------------------------");
      }

      final Response response = await _dio.post(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      if (kDebugMode) {
        print("-----------Response-------------\n $response",);
        print("--------------------------------");
      }

      return response;
    } catch (e) {
      if (kDebugMode) {
        print("-----------Error-------------\n $e");
        print("-----------------------------");
      }
      rethrow;
    }
  }

  Future<void> commonParameters(data) async {
    final fcmToken = await FirebaseMessaging.instance.getToken();
    final deviceType = Platform.isAndroid ? "A" : "I";
    data["device_token"] = fcmToken;
    data["device_type"] = deviceType;
  }

  // Put:-----------------------------------------------------------------------
  Future<Response> put(
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.put(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // Delete:--------------------------------------------------------------------
  Future<dynamic> delete(
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.delete(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response.data;
    } catch (e) {
      rethrow;
    }
  }
}
