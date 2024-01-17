import 'package:dio/dio.dart';
import 'package:inquiryapp/common/network/api_manager/api_urls_endpoints.dart';
import 'package:inquiryapp/common/network/dio_client.dart';

class ForgotPasswordApi {
  final DioClient dioClient;

  ForgotPasswordApi({required this.dioClient});

  Future<Response> forgotPassword({
    required String mobile,
  }) async {
    try {
      final params = {
        'mobile': mobile,
      };

      final Response response = await dioClient.post(APIEndPoints.forgotPassword,
          data: params);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> resetPassword({
    required String mobile,
    required String password,
    required String confirmPassword,
  }) async {
    try {
      final params = {
        'mobile': mobile,
        'password': password,
        'confirmPassword': confirmPassword,
      };

      final Response response = await dioClient.post(APIEndPoints.resetPassword,
          data: params);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
