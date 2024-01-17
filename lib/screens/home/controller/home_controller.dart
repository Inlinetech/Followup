import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inquiryapp/common/base_data_model.dart';
import 'package:inquiryapp/common/singleton_services.dart';
import 'package:inquiryapp/common/utillity_helper.dart';
import 'package:inquiryapp/screens/add_lead/api/add_lead_repository.dart';
import 'package:inquiryapp/screens/home/api/home_repository.dart';
import 'package:inquiryapp/screens/home/model/lead_data_model.dart';
import 'package:inquiryapp/screens/signup/api/signup_repository.dart';
import 'package:inquiryapp/screens/signup/model/business_category_model.dart';

class HomeDataController extends GetxController {
  final homeRepo = getIt.get<HomeRepository>();

  // //ClassType
  // String? get classType => _classType;
  //
  // String? _classType;
  //
  // setClassType(String? value) {
  //   _classType = value;
  //   update();
  // }

  //Leads
  List<LeadDataModel> get leads => _leads;

  List<LeadDataModel> _leads = [];

  setLeads(List<LeadDataModel> value) {
    _leads = value;
    update();
  }

  updateLeadById(LeadDataModel? lead) {
    if (lead == null) {
      return;
    }
    final index = _leads.indexWhere((element) => element.id == lead.id);
    _leads[index] = lead;
    update();
  }

  Future getLeads({String? classType,DateTimeRange? dateRange}) async {
    UtilityHelper.instance.showLoader();
    try {
      final responseModel = await homeRepo.getLeads(classType: classType,dateRange: dateRange);
      setLeads(responseModel.data ?? []);
      UtilityHelper.instance.hideLoader();
    } catch (error) {
      UtilityHelper.instance.hideLoader();
    }

  }

}
