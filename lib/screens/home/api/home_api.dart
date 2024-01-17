import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as GetX;
import 'package:inquiryapp/common/network/api_manager/api_urls_endpoints.dart';
import 'package:inquiryapp/common/network/dio_client.dart';
import 'package:inquiryapp/common/utillity_helper.dart';
import 'package:inquiryapp/screens/signin/controller/signin_controller.dart';

class HomeApi {
  final DioClient dioClient;

  HomeApi({required this.dioClient});

  Future<Response> getLeadsApi({String? classType,DateTimeRange? dateRange}) async {
    try {
      final SignInDataController signInDataController = GetX.Get.find();
      final headers = {
        "Authorization": 'Bearer ${signInDataController.user?.token}'
      };

      var url = APIEndPoints.getLeads;
      if (classType != null) {
        url = '$url&class_type=$classType';
      }

      if (dateRange != null) {
        DateTime startDate = dateRange.start;
        DateTime endDate = dateRange.end;
        String startDateString = UtilityHelper.instance.convertDateToString(startDate, "yyyy-MM-dd");
        String endDateString = UtilityHelper.instance.convertDateToString(endDate, "yyyy-MM-dd");
        url = '$url&start_date=$startDateString&end_date=$endDateString';
      }

      final Response response = await dioClient.get(
          url,options: Options(
          headers:headers)
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
