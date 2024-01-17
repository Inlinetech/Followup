import 'package:dio/dio.dart';
import 'package:inquiryapp/common/base_data_model.dart';
import 'package:inquiryapp/common/network/dio_exceptions.dart';
import 'package:inquiryapp/screens/lead_details/api/lead_detail_api.dart';
import 'package:inquiryapp/screens/lead_details/model/lead_details_model.dart';

class LeadDetailsRepository {
  final LeadDetailsApi leadDetailsApi;

  LeadDetailsRepository(this.leadDetailsApi);

  Future<BaseDataModel> deleteLead({
    required String id,
  }) async {
    try {
      final response = await leadDetailsApi.deleteLeadApi(
        id: id,
      );
      return BaseDataModel.fromJson(response.data);
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future<ReminderStatusDataModel> markAsFraud({
    required String id,
    required String action,
  }) async {
    try {
      final response = await leadDetailsApi.markAsFraudApi(
        id: id,
        action: action
      );
      return ReminderStatusDataModel.fromJson(response.data);
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future<ReminderStatusDataModel> reminderStatus({
    required String id,
    required String action,
  }) async {
    try {
      final response = await leadDetailsApi.leadReminderStatusApi(
          id: id,
          action: action
      );
      return ReminderStatusDataModel.fromJson(response.data);
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }
}
