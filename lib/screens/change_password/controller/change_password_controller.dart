import 'package:get/get.dart';
import 'package:inquiryapp/common/singleton_services.dart';
import 'package:inquiryapp/common/utillity_helper.dart';
import 'package:inquiryapp/screens/change_password/api/change_password_repository.dart';
import 'package:inquiryapp/screens/change_password/model/change_password_model.dart';

class ChangePasswordController extends GetxController {
  final changePasswordRepo = getIt.get<ChangePasswordRepository>();

  Future<ChangePasswordDataModel> changePassword({ required String oldPassword,
    required String newPassword,
    required String confirmPassword,}) async {
    UtilityHelper.instance.showLoader();

    final responseModel = await changePasswordRepo.changePassword(
        oldPassword: oldPassword,
        newPassword: newPassword,
        confirmPassword: confirmPassword
    );

    UtilityHelper.instance.hideLoader();
    return responseModel;
  }

}
