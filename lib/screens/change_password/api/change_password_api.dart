import 'package:dio/dio.dart';
import 'package:get/get.dart' as GetX;
import 'package:inquiryapp/common/network/api_manager/api_urls_endpoints.dart';
import 'package:inquiryapp/common/network/dio_client.dart';
import 'package:inquiryapp/screens/signin/controller/signin_controller.dart';

class ForgetPasswordApi {
  final DioClient dioClient;

  ForgetPasswordApi({required this.dioClient});

  Future<Response> changePasswordApi({
    required String oldPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    try {
      final params = {
        'currentPassword': oldPassword,
        'password': newPassword,
        'confirmPassword': confirmPassword,
      };

      final SignInDataController signInDataController = GetX.Get.find();
      final headers = {
        "Authorization": 'Bearer ${signInDataController.user?.token}'
      };


      final Response response = await dioClient.post(APIEndPoints.changePassword,
          data: params, options: Options(headers: headers));
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
