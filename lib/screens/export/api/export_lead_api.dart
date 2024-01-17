import 'package:dio/dio.dart';
import 'package:get/get.dart' as GetX;
import 'package:inquiryapp/common/network/api_manager/api_urls_endpoints.dart';
import 'package:inquiryapp/common/network/dio_client.dart';
import 'package:inquiryapp/screens/signin/controller/signin_controller.dart';

class ExportLeadApi {
  final DioClient dioClient;

  ExportLeadApi({required this.dioClient});

  Future<Response> exportLeadApi({
    required String ids,
  }) async {
    try {
      final params = {
        'id': ids,
      };

      final SignInDataController signInDataController = GetX.Get.find();
      final headers = {
        "Authorization": 'Bearer ${signInDataController.user?.token}'
      };

      print(headers);
      final Response response = await dioClient.post(APIEndPoints.exportLeads,
          data: params, options: Options(headers: headers));
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
