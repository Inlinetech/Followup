import 'package:dio/dio.dart';
import 'package:inquiryapp/common/network/dio_exceptions.dart';
import 'package:inquiryapp/screens/change_password/api/change_password_api.dart';
import 'package:inquiryapp/screens/change_password/model/change_password_model.dart';

class ChangePasswordRepository {
  final ForgetPasswordApi changePasswordApi;

  ChangePasswordRepository(this.changePasswordApi);

  Future<ChangePasswordDataModel> changePassword({
    required String oldPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    try {
      final response = await changePasswordApi.changePasswordApi(
          oldPassword: oldPassword,
          newPassword: newPassword,
          confirmPassword: confirmPassword);
      return ChangePasswordDataModel.fromJson(response.data);
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }
}
