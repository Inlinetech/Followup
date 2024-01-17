import 'package:dio/dio.dart';
import 'package:inquiryapp/common/base_data_model.dart';
import 'package:inquiryapp/common/network/dio_exceptions.dart';
import 'package:inquiryapp/screens/signin/model/signin_data_model.dart';
import 'package:inquiryapp/screens/verifyotp/api/verifyotp_api.dart';

class VerifyOtpRepository {
  final VerifyOtpApi verifyOtpApi;

  VerifyOtpRepository(this.verifyOtpApi);

  Future<SigninDataModel> otpVerificationOrResend(
      {required String mobile,
      String? otp,
      required String type}) async {
    try {
      final response = await verifyOtpApi.otpVerificationOrResendApi(
          mobile: mobile, otp: otp, type: type);
      return SigninDataModel.fromJson(response.data);
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future<BaseDataModel> forgotOtpVerification(
      {required String mobile,
        String? otp}) async {
    try {
      final response = await verifyOtpApi.otpVerificationOrResendApi(
          mobile: mobile, otp: otp, type: '3');
      return BaseDataModel.fromJson(response.data);
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }
}
