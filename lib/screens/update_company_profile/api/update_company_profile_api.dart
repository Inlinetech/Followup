import 'package:dio/dio.dart';
import 'package:get/get.dart' as GetX;
import 'package:inquiryapp/common/network/api_manager/api_urls_endpoints.dart';
import 'package:inquiryapp/common/network/dio_client.dart';
import 'package:inquiryapp/screens/signin/controller/signin_controller.dart';

class UpdateCompanyProfileApi {
  final DioClient dioClient;

  UpdateCompanyProfileApi({required this.dioClient});

  Future<Response> updateCompanyProfileApi({
    required String companyName,
    required String businessCategoryId,
    required String businessTypeId,
    required String state,
    required String city,
  }) async {
    try {
      final params = {
        'company_name': companyName,
        'business_category_id': businessCategoryId,
        'business_type_id': businessTypeId,
        'state': state,
        'city': city,
      };

      final SignInDataController signInDataController = GetX.Get.find();
      final headers = {
        "Authorization": 'Bearer ${signInDataController.user?.token}'
      };


      final Response response = await dioClient.post(APIEndPoints.updateProfile,
          data: params, options: Options(headers: headers));
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
