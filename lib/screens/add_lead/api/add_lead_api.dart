import 'package:dio/dio.dart';
import 'package:get/get.dart' as GetX;
import 'package:inquiryapp/common/network/api_manager/api_urls_endpoints.dart';
import 'package:inquiryapp/common/network/dio_client.dart';
import 'package:inquiryapp/screens/signin/controller/signin_controller.dart';

class AddLeadApi {
  final DioClient dioClient;

  AddLeadApi({required this.dioClient});

  Future<Response> createLeadApi({
    required String cassTypeId,
    required String leadName,
    required String mobile,
    required String address,
    required String address1,
    required String pinCode,
    required String city,
    required String landmark,
    required String shopName,
    required String notes,
    required String customMessage,
    required String reminderType,
    required String reminderDate,
  }) async {
    try {
      final params = {
        'customers_class_type_id': cassTypeId,
        'lead_name': leadName,
        'mobile': mobile,
        'address': address,
        'address1': address1,
        'pincode': pinCode,
        'city': city,
        'landmark': landmark,
        'shop_name': shopName,
        'custom_message': customMessage,
        'notes': notes,
        'reminder_type': reminderType,
      };
      if (reminderType == '3') {
        params['specific_date'] = reminderDate;
      }
      final SignInDataController signInDataController = GetX.Get.find();
      final headers = {
        "Authorization": 'Bearer ${signInDataController.user?.token}'
      };

      print(headers);
      final Response response = await dioClient.post(APIEndPoints.addLead,
          data: params,
          options: Options(
              headers:headers));
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> getLeadCategoriesApi() async {
    try {
      final Response response = await dioClient.get(
        APIEndPoints.leadCategory,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
