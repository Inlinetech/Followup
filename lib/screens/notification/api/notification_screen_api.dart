import 'package:dio/dio.dart';
import 'package:get/get.dart' as GetX;
import 'package:inquiryapp/common/network/api_manager/api_urls_endpoints.dart';
import 'package:inquiryapp/common/network/dio_client.dart';
import 'package:inquiryapp/screens/signin/controller/signin_controller.dart';

class NotificationApi {
  final DioClient dioClient;

  NotificationApi({required this.dioClient});

  Future<Response> getNotificationApi() async {
    try {
      final SignInDataController signInDataController = GetX.Get.find();
      final headers = {
        "Authorization": 'Bearer ${signInDataController.user?.token}'
      };

      final Response response = await dioClient.get(APIEndPoints.notification, options: Options(headers: headers));
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
