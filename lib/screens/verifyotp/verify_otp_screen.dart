import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:inquiryapp/common/app_colors.dart';
import 'package:inquiryapp/common/app_enums.dart';
import 'package:inquiryapp/common/app_image.dart';
import 'package:inquiryapp/common/app_routes.dart';
import 'package:inquiryapp/common/app_strings.dart';
import 'package:inquiryapp/common/app_textstyle.dart';
import 'package:inquiryapp/common/utillity_helper.dart';
import 'package:inquiryapp/common/widgets/app_text_button.dart';
import 'package:inquiryapp/screens/forgot_password/controller/forgot_password_controller.dart';
import 'package:inquiryapp/screens/signin/controller/signin_controller.dart';
import 'package:inquiryapp/screens/verifyotp/controller/verifyotp_controller.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';

class VerifyOTPScreen extends StatefulWidget {
  const VerifyOTPScreen({
    super.key,
    required this.mobile,
    required this.fromScreen,
  });

  final String mobile;
  final FromVerifyOTPType fromScreen;

  @override
  State<VerifyOTPScreen> createState() => _VerifyOTPScreenState();
}

class _VerifyOTPScreenState extends State<VerifyOTPScreen> {
  final ForgotPasswordController forgotPasswordController = Get.put(ForgotPasswordController());
  final SignInDataController signInDataController =
      Get.put(SignInDataController());
  final VerifyOtpDataController verifyOtpDataController =
      Get.put(VerifyOtpDataController());
  String? otpCode;
  OtpFieldController otpController = OtpFieldController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15).r,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: SvgPicture.asset(AppImage.iconBackBlack),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                        padding: EdgeInsets.symmetric(vertical: 60.h),
                        child: SvgPicture.asset(
                            AppImage.verifyOTPBackgroundImage)),
                    Text(
                      AppStrings.verifyTitle,
                      style: AppTextStyle.instance.semiBoldBlack27,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      AppStrings.verifyDescText,
                      style: AppTextStyle.instance.lightGrey16,
                    ),
                    SizedBox(
                      height: 35.h,
                    ),
                    OTPTextField(
                      length: 6,
                      width: 1.sw,
                      controller: otpController,
                      fieldWidth: (1.sw) / 8,
                      style: AppTextStyle.instance.semiBoldBlack18,
                      textFieldAlignment: MainAxisAlignment.spaceBetween,
                      fieldStyle: FieldStyle.box,
                      otpFieldStyle: OtpFieldStyle(
                        focusBorderColor: AppColors.primary,
                        enabledBorderColor: AppColors.pink,
                        borderColor: AppColors.primary,
                      ),
                      onChanged: (value) {
                        otpCode = value;
                      },
                      onCompleted: (pin) {
                        otpCode = pin;
                        if (kDebugMode) {
                          print("Completed: $pin");
                        }
                      },
                    ),
                    SizedBox(
                      height: 35.h,
                    ),
                    AppTextButton(
                      title: AppStrings.verify,
                      onPressed: () async {
                        if (isValidate()) {
                          final type = widget.fromScreen ==
                                  FromVerifyOTPType.forgotPassword
                              ? '3'
                              : '1';

                          if (type == '3') {
                            final responseModel = await verifyOtpDataController
                                .forgotOtpVerification(
                                mobile: widget.mobile,
                                otp: otpCode);
                            if (responseModel.status ?? false) {
                              Get.offNamed(AppRoutes.resetPassword,arguments: [
                                widget.mobile
                              ]);
                            } else {
                              UtilityHelper.instance.showError(AppStrings.error,
                                  responseModel.message ?? "");
                            }
                          } else {
                            final responseModel = await verifyOtpDataController
                                .otpVerificationOrResend(
                                mobile: widget.mobile,
                                type: type,
                                otp: otpCode);
                            if (responseModel.status ?? false) {
                              if (responseModel.data != null) {
                                signInDataController
                                    .setUserDataModel(responseModel.data!);
                              }
                              //Success Screen
                              Get.offAllNamed(AppRoutes.successScreen,
                                  arguments: [
                                    AppStrings.successful,
                                    responseModel.message ?? '',
                                    true,
                                    AppColors.primary,
                                    true,
                                    FromSuccessType.verifyOtp,
                                    false
                                  ]);
                            } else {
                              UtilityHelper.instance.showError(AppStrings.error,
                                  responseModel.message ?? "");
                            }
                          }
                        }
                      },
                    ),
                    SizedBox(
                      height: 35.h,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          AppStrings.dontReceiveYet,
                          style: AppTextStyle.instance.lightGrey14,
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        GestureDetector(
                          onTap: () async {
                            setState(() {
                              otpCode = null;
                            });
                            otpController.clear();

                            if (widget.fromScreen == FromVerifyOTPType.forgotPassword) {
                              final responseModel = await forgotPasswordController.forgotPassword(mobile: widget.mobile);
                              if (responseModel.status ?? false) {
                                UtilityHelper.instance.showSuccess(
                                    AppStrings.successful,
                                    responseModel.message ??
                                        "OTP Resend Successfully");
                              } else {
                                UtilityHelper.instance.showError(
                                    AppStrings.error, responseModel.message ?? '');
                              }
                            } else {
                              final response = await verifyOtpDataController
                                  .otpVerificationOrResend(
                                  mobile: widget.mobile, type: "2");
                              if (response.status ?? false) {
                                UtilityHelper.instance.showSuccess(
                                    AppStrings.successful,
                                    response.message ??
                                        "OTP Resend Successfully");
                              } else {
                                UtilityHelper.instance.showError(
                                    AppStrings.error, response.message ?? "");
                              }
                            }

                          },
                          child: Text(
                            AppStrings.resend,
                            style: AppTextStyle.instance.lightGreyUndeline14,
                          ),
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool isValidate() {
    return true;
    if (otpCode == null) {
      UtilityHelper.instance
          .showError(AppStrings.error, "Please enter valid otp");
      return false;
    } else if (otpCode?.length != 6) {
      UtilityHelper.instance
          .showError(AppStrings.error, "Please enter valid otp");
      return false;
    }
    return true;
  }
}
