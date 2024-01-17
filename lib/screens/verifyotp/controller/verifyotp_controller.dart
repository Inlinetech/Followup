import 'package:get/get.dart';
import 'package:inquiryapp/common/base_data_model.dart';
import 'package:inquiryapp/common/singleton_services.dart';
import 'package:inquiryapp/common/utillity_helper.dart';
import 'package:inquiryapp/screens/signin/model/signin_data_model.dart';
import 'package:inquiryapp/screens/verifyotp/api/verifyotp_repository.dart';

class VerifyOtpDataController extends GetxController {
  final verifyOtpRepo = getIt.get<VerifyOtpRepository>();

  Future<SigninDataModel> otpVerificationOrResend(
      {required String mobile,
        String? otp,
        required String type}) async {
    UtilityHelper.instance.showLoader();
    final responseModel = await verifyOtpRepo.otpVerificationOrResend(
        mobile: mobile,
        otp: otp,
        type: type);
    UtilityHelper.instance.hideLoader();
    return responseModel;
  }

  Future<BaseDataModel> forgotOtpVerification(
      {required String mobile,
        String? otp}) async {
    UtilityHelper.instance.showLoader();
    final responseModel = await verifyOtpRepo.forgotOtpVerification(
        mobile: mobile,
        otp: otp);
    UtilityHelper.instance.hideLoader();
    return responseModel;
  }
}
