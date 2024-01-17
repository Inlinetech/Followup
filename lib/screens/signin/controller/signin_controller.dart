import 'package:get/get.dart';
import 'package:inquiryapp/common/shared_pref_helper.dart';
import 'package:inquiryapp/common/singleton_services.dart';
import 'package:inquiryapp/common/utillity_helper.dart';
import 'package:inquiryapp/screens/signin/api/signin_repository.dart';
import 'package:inquiryapp/screens/signin/model/signin_data_model.dart';

class SignInDataController extends GetxController {

  UserDataModel? get user => _user;

  UserDataModel? _user;

  setUserDataModel(UserDataModel value) async {
    _user = value;
    await SharedPref.save("user", value);
    update();
  }

  setUserProfileDataModel(UserDataModel value) async {
    final profileData = value;
    profileData.token = _user?.token;
    _user = profileData;
    await SharedPref.save("user", profileData);
    update();
  }

  final signInRepo = getIt.get<SignInRepository>();

  Future<SigninDataModel> userLogin(
      {required String userName,
        required String password}) async {
    UtilityHelper.instance.showLoader();
    final responseModel = await signInRepo.userLogin(
        userName: userName,
        password: password);
    UtilityHelper.instance.hideLoader();
    return responseModel;
  }
}
