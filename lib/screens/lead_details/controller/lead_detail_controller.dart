import 'package:get/get.dart';
import 'package:inquiryapp/common/base_data_model.dart';
import 'package:inquiryapp/common/singleton_services.dart';
import 'package:inquiryapp/common/utillity_helper.dart';
import 'package:inquiryapp/screens/lead_details/api/lead_detail_repository.dart';
import 'package:inquiryapp/screens/lead_details/model/lead_details_model.dart';

class LeadDetailsController extends GetxController {
  final leadDetailsRepo = getIt.get<LeadDetailsRepository>();

  Future<BaseDataModel> deleteLead({ required String id}) async {
    UtilityHelper.instance.showLoader();

    final responseModel = await leadDetailsRepo.deleteLead(
        id: id
    );

    UtilityHelper.instance.hideLoader();
    return responseModel;
  }

  Future<ReminderStatusDataModel> markAsFraud({ required String id,required String action}) async {
    UtilityHelper.instance.showLoader();

    final responseModel = await leadDetailsRepo.markAsFraud(
        id: id,
        action: action
    );

    UtilityHelper.instance.hideLoader();
    return responseModel;
  }

  Future<ReminderStatusDataModel> reminderStatus({ required String id,required String action}) async {
    UtilityHelper.instance.showLoader();

    final responseModel = await leadDetailsRepo.reminderStatus(
        id: id,
        action: action
    );

    UtilityHelper.instance.hideLoader();
    return responseModel;
  }
}
