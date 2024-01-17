import 'package:dio/dio.dart';
import 'package:inquiryapp/common/network/dio_exceptions.dart';
import 'package:inquiryapp/screens/export/api/export_lead_api.dart';
import 'package:inquiryapp/screens/export/model/export_lead_model.dart';

class ExportLeadRepository {
  final ExportLeadApi exportLeadApi;

  ExportLeadRepository(this.exportLeadApi);

  Future<ExportLeadBaseModel> exportLeads({
    required String ids,
  }) async {
    try {
      final response = await exportLeadApi.exportLeadApi(ids: ids);
      return ExportLeadBaseModel.fromJson(response.data);
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }
}
