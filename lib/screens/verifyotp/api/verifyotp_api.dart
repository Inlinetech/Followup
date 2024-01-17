import 'package:dio/dio.dart';
import 'package:inquiryapp/common/network/api_manager/api_urls_endpoints.dart';
import 'package:inquiryapp/common/network/dio_client.dart';

class VerifyOtpApi {
  final DioClient dioClient;

  VerifyOtpApi({required this.dioClient});

  Future<Response> otpVerificationOrResendApi(
      {required String mobile,
      String? otp,
      required String type}) async {
    try {
      var params = <String, String>{};
      if (type == '2') {
        // Resend OTP API
        params = {
          'mobile': mobile,
          'type': type,
        };
      } else {
        // OTP Verification or Forgot Password Verification
        params = {
          'mobile': mobile,
          'otp': otp ?? '',
          'type': type,
        };
      }

      final Response response = await dioClient.post(
        APIEndPoints.otpVerification,
        data: params,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
