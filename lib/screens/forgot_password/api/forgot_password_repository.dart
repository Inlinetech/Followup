import 'package:dio/dio.dart';
import 'package:inquiryapp/common/base_data_model.dart';
import 'package:inquiryapp/common/network/dio_exceptions.dart';
import 'package:inquiryapp/screens/forgot_password/api/forgot_password_api.dart';

class ForgotPasswordRepository {
  final ForgotPasswordApi forgetPasswordApi;

  ForgotPasswordRepository(this.forgetPasswordApi);

  Future<BaseDataModel> forgetPassword({
    required String mobile,
  }) async {
    try {
      final response = await forgetPasswordApi.forgotPassword(mobile: mobile);
      return BaseDataModel.fromJson(response.data);
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future<BaseDataModel> resetPassword({
    required String mobile,
    required String password,
    required String confirmPassword,
  }) async {
    try {
      final response = await forgetPasswordApi.resetPassword(
          mobile: mobile,
          password: password,
          confirmPassword: confirmPassword);
      return BaseDataModel.fromJson(response.data);
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }
}
