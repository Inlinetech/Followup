import 'package:dio/dio.dart';
import 'package:inquiryapp/common/network/dio_exceptions.dart';
import 'package:inquiryapp/screens/signin/model/signin_data_model.dart';
import 'package:inquiryapp/screens/update_company_profile/api/update_company_profile_api.dart';

class UpdateCompanyProfileRepository {
  final UpdateCompanyProfileApi updateCompanyApi;

  UpdateCompanyProfileRepository(this.updateCompanyApi);

  Future<SigninDataModel> updateCompanyProfile({
    required String companyName,
    required String businessCategoryId,
    required String businessTypeId,
    required String state,
    required String city,
  }) async {
    try {
      final response = await updateCompanyApi.updateCompanyProfileApi(
          companyName: companyName,
          businessCategoryId: businessCategoryId,
          businessTypeId: businessTypeId,state:state,city: city);
      return SigninDataModel.fromJson(response.data);
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }
}
