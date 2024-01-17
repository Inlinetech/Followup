import 'package:dio/dio.dart';
import 'package:get/get.dart' as GetX;
import 'package:inquiryapp/common/network/api_manager/api_urls_endpoints.dart';
import 'package:inquiryapp/common/network/dio_client.dart';
import 'package:inquiryapp/screens/signin/controller/signin_controller.dart';

class LeadDetailsApi {
  final DioClient dioClient;

  LeadDetailsApi({required this.dioClient});

  Future<Response> deleteLeadApi({
    required String id,
  }) async {
    try {
      final params = {
        'id': id,
      };

      final SignInDataController signInDataController = GetX.Get.find();
      final headers = {
        "Authorization": 'Bearer ${signInDataController.user?.token}'
      };

      final Response response = await dioClient.post(APIEndPoints.leadDetails,
          data: params, options: Options(headers: headers));
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> markAsFraudApi({
    required String id,
    required String action,
  }) async {
    try {
      final params = {
        'id': id,
        'action': action
      };

      final SignInDataController signInDataController = GetX.Get.find();
      final headers = {
        "Authorization": 'Bearer ${signInDataController.user?.token}'
      };

      final Response response = await dioClient.post(APIEndPoints.leadFraud,
          data: params, options: Options(headers: headers));
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> leadReminderStatusApi({
    required String id,
    required String action,
  }) async {
    try {
      final params = {
        'id': id,
        'action': action
      };

      final SignInDataController signInDataController = GetX.Get.find();
      final headers = {
        "Authorization": 'Bearer ${signInDataController.user?.token}'
      };

      final Response response = await dioClient.post(APIEndPoints.leadReminderStatus,
          data: params, options: Options(headers: headers));
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
