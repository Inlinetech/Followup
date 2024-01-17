import 'package:dio/dio.dart';
import 'package:inquiryapp/common/app_strings.dart';
import 'package:inquiryapp/common/network/dio_exceptions.dart';
import 'package:inquiryapp/common/utillity_helper.dart';
import 'package:inquiryapp/screens/signin/api/signin_api.dart';
import 'package:inquiryapp/screens/signin/model/signin_data_model.dart';

class SignInRepository {
  final SignInApi singInApi;

  SignInRepository(this.singInApi);

  Future<SigninDataModel> userLogin(
      {required String userName,
        required String password}) async {
    try {
      final response = await singInApi.userLoginApi(userName: userName,password: password);
      return SigninDataModel.fromJson(response.data);
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      UtilityHelper.instance.showError(AppStrings.error, errorMessage);
      throw errorMessage;
    }
  }
}
