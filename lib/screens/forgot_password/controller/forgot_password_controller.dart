import 'package:get/get.dart';
import 'package:inquiryapp/common/base_data_model.dart';
import 'package:inquiryapp/common/singleton_services.dart';
import 'package:inquiryapp/common/utillity_helper.dart';
import 'package:inquiryapp/screens/forgot_password/api/forgot_password_repository.dart';

class ForgotPasswordController extends GetxController {
  final forgotPasswordRepo = getIt.get<ForgotPasswordRepository>();

  Future<BaseDataModel> forgotPassword({ required String mobile}) async {
    UtilityHelper.instance.showLoader();

    final responseModel = await forgotPasswordRepo.forgetPassword(
        mobile: mobile,
    );

    UtilityHelper.instance.hideLoader();
    return responseModel;
  }

  Future<BaseDataModel> resetPassword({ required String mobile,required String password,required String confirmPassword,}) async {
    UtilityHelper.instance.showLoader();

    final responseModel = await forgotPasswordRepo.resetPassword(
      mobile: mobile,
      password: password,
      confirmPassword: confirmPassword
    );

    UtilityHelper.instance.hideLoader();
    return responseModel;
  }

}
