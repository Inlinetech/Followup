import 'package:get/get.dart';
import 'package:inquiryapp/common/base_data_model.dart';
import 'package:inquiryapp/common/singleton_services.dart';
import 'package:inquiryapp/common/utillity_helper.dart';
import 'package:inquiryapp/screens/add_lead/api/add_lead_repository.dart';
import 'package:inquiryapp/screens/signup/api/signup_repository.dart';
import 'package:inquiryapp/screens/signup/model/business_category_model.dart';

class AddLeadDataController extends GetxController {
  final addLeadRepo = getIt.get<AddLeadRepository>();

  Future<BaseDataModel> createLead(
      {required String cassTypeId,
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
        required String reminderDate,}) async {
    // UtilityHelper.instance.showLoader();
    final newlyAddedLead = await addLeadRepo.createLead(
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
      reminderDate: reminderDate,);
    UtilityHelper.instance.hideLoader();
    return newlyAddedLead;
  }

  //Business Categories
  List<Category> get leadCategory => _leadCategory;

  List<Category> _leadCategory = [];

  setLeadCategory(List<Category> value) {
    _leadCategory = value;
    update();
  }

  Future getLeadCategories() async {
    UtilityHelper.instance.showLoader();
    final responseModel = await addLeadRepo.getLeadCategories();
    setLeadCategory(responseModel.data ?? []);
    UtilityHelper.instance.hideLoader();
  }

}
