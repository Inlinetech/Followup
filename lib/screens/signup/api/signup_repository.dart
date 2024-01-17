import 'package:dio/dio.dart';
import 'package:inquiryapp/common/base_data_model.dart';
import 'package:inquiryapp/common/network/dio_exceptions.dart';
import 'package:inquiryapp/screens/signup/api/signup_api.dart';
import 'package:inquiryapp/screens/signup/model/business_category_model.dart';

class SignupRepository {
  final SignupApi signupApi;

  SignupRepository(this.signupApi);

  Future<BaseDataModel> registerUser(
      {required String userName,
      required String email,
      required String mobile,
      required String password,
      required String businessCategoryId}) async {
    try {
      final response = await signupApi.registerUserApi(
          userName: userName,
          mobile: mobile,
          email: email,
          password: password,
          businessCategoryId: businessCategoryId);
      return BaseDataModel.fromJson(response.data);
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future<CategoryBaseModel> getBusinessCategories() async {
    try {
      final response = await signupApi.getBusinessCategoriesApi();
      return CategoryBaseModel.fromJson(response.data);
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future<CategoryBaseModel> getBusinessTypes() async {
    try {
      final response = await signupApi.getBusinessTypesApi();
      return CategoryBaseModel.fromJson(response.data);
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

}
