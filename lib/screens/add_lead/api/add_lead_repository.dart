import 'package:dio/dio.dart';
import 'package:inquiryapp/common/base_data_model.dart';
import 'package:inquiryapp/common/network/dio_exceptions.dart';
import 'package:inquiryapp/screens/add_lead/api/add_lead_api.dart';
import 'package:inquiryapp/screens/signup/api/signup_api.dart';
import 'package:inquiryapp/screens/signup/model/business_category_model.dart';

class AddLeadRepository {
  final AddLeadApi addLeadApi;

  AddLeadRepository(this.addLeadApi);

  Future<BaseDataModel> createLead({
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
      final response = await addLeadApi.createLeadApi(
        cassTypeId: cassTypeId,
        leadName: leadName,
        mobile: mobile,
        address: address,
        address1: address1,
        pinCode: pinCode,
        city: city,
        landmark: landmark,
        shopName: shopName,
        notes: notes,
        customMessage: customMessage,
        reminderType: reminderType,
        reminderDate: reminderDate,
      );
      return BaseDataModel.fromJson(response.data);
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future<CategoryBaseModel> getLeadCategories() async {
    try {
      final response = await addLeadApi.getLeadCategoriesApi();
      return CategoryBaseModel.fromJson(response.data);
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }
}
