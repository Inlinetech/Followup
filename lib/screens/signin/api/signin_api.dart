import 'package:dio/dio.dart';
import 'package:inquiryapp/common/network/api_manager/api_urls_endpoints.dart';
import 'package:inquiryapp/common/network/dio_client.dart';

class SignInApi {
  final DioClient dioClient;

  SignInApi({required this.dioClient});

  Future<Response> userLoginApi(
      {required String userName,
        required String password}) async {
    try {
      var params = {
        'username': userName,
        'password': password,
      };

      final Response response = await dioClient.post(
        APIEndPoints.login,
        data: params,
        isCommonParamsAdd: true
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
