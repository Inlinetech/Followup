import 'package:get/get.dart';
import 'package:inquiryapp/common/base_data_model.dart';
import 'package:inquiryapp/common/singleton_services.dart';
import 'package:inquiryapp/common/utillity_helper.dart';
import 'package:inquiryapp/screens/signup/api/signup_repository.dart';
import 'package:inquiryapp/screens/signup/model/business_category_model.dart';

class SignupDataController extends GetxController {
  final signupRepo = getIt.get<SignupRepository>();

  Future<BaseDataModel> addNewUser(
      {required String userName,
      required String email,
      required String mobile,
      required String password,
      required String businessCategoryId}) async {
    UtilityHelper.instance.showLoader();
    final newlyAddedUser = await signupRepo.registerUser(
        userName: userName,
        email: email,
        mobile: mobile,
        password: password,
        businessCategoryId: businessCategoryId);
    UtilityHelper.instance.hideLoader();
    return newlyAddedUser;
  }

  //Business Categories
  List<Category> get businessCategory => _businessCategory;

  List<Category> _businessCategory = [];

  setBusinessCategory(List<Category> value) {
    _businessCategory = value;
    update();
  }

  Future getBusinessCategories() async {
    UtilityHelper.instance.showLoader();
    final responseModel = await signupRepo.getBusinessCategories();
    setBusinessCategory(responseModel.data ?? []);
    UtilityHelper.instance.hideLoader();
  }

  Category? getBusinessCategoryById(String id) {
    if (_businessCategory.isNotEmpty) {
      return _businessCategory.firstWhere((element) => element.id == id);
    }
    return null;
  }

  //Business Types
  List<Category> get businessTypes => _businessTypes;

  List<Category> _businessTypes = [];

  setBusinessTypes(List<Category> value) {
    _businessTypes = value;
    update();
  }

  Future getBusinessTypes() async {
    UtilityHelper.instance.showLoader();
    final responseModel = await signupRepo.getBusinessTypes();
    setBusinessTypes(responseModel.data ?? []);
    UtilityHelper.instance.hideLoader();
  }

  Category? getBusinessTypesById(String id) {
    if (_businessTypes.isNotEmpty) {
      return _businessTypes.firstWhere((element) => element.id == id);
    }
    return null;

  }
}
