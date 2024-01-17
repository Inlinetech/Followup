import 'package:dio/dio.dart';
import 'package:inquiryapp/common/network/api_manager/api_urls_endpoints.dart';
import 'package:inquiryapp/common/network/dio_client.dart';

class SignupApi {
  final DioClient dioClient;

  SignupApi({required this.dioClient});

  Future<Response> registerUserApi(
      {required String userName,
      required String email,
      required String mobile,
      required String password,
      required String businessCategoryId}) async {
    try {
      final params = {
        'username': userName,
        'email': email,
        'mobile': mobile,
        'password': password,
        'business_category_id': businessCategoryId
      };

      final Response response = await dioClient.post(
        APIEndPoints.register,
        data: params,
        isCommonParamsAdd: true
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> getBusinessCategoriesApi() async {
    try {
      final Response response = await dioClient.get(
        APIEndPoints.businessCategory,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> getBusinessTypesApi() async {
    try {
      final Response response = await dioClient.get(
        APIEndPoints.businessTypes,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
