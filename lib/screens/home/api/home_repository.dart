import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:inquiryapp/common/base_data_model.dart';
import 'package:inquiryapp/common/network/dio_exceptions.dart';
import 'package:inquiryapp/screens/add_lead/api/add_lead_api.dart';
import 'package:inquiryapp/screens/home/api/home_api.dart';
import 'package:inquiryapp/screens/home/model/lead_data_model.dart';
import 'package:inquiryapp/screens/signup/api/signup_api.dart';
import 'package:inquiryapp/screens/signup/model/business_category_model.dart';

class HomeRepository {
  final HomeApi homeApi;

  HomeRepository(this.homeApi);

  Future<LeadBaseModel> getLeads({String? classType,DateTimeRange? dateRange}) async {
    try {
      final response = await homeApi.getLeadsApi(classType: classType,dateRange: dateRange);
      return LeadBaseModel.fromJson(response.data);
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }
}
