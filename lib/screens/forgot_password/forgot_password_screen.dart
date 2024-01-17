import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:inquiryapp/common/app_enums.dart';
import 'package:inquiryapp/common/app_image.dart';
import 'package:inquiryapp/common/app_routes.dart';
import 'package:inquiryapp/common/app_strings.dart';
import 'package:inquiryapp/common/app_textstyle.dart';
import 'package:inquiryapp/common/utillity_helper.dart';
import 'package:inquiryapp/common/widgets/app_text_button.dart';
import 'package:inquiryapp/common/widgets/app_text_form_field.dart';
import 'package:inquiryapp/screens/forgot_password/controller/forgot_password_controller.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController mobileController = TextEditingController();
  final ForgotPasswordController forgotPasswordController = Get.put(ForgotPasswordController());
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
                        padding: EdgeInsets.only(
                            top: 60.h, bottom: 60.h, right: 30.w),
                        child:
                            SvgPicture.asset(AppImage.forgotBackgroundImage)),
                    Text(
                      AppStrings.forgotTitle,
                      style: AppTextStyle.instance.semiBoldBlack27,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      AppStrings.forgotDescText,
                      style: AppTextStyle.instance.lightGrey16,
                    ),
                    SizedBox(
                      height: 35.h,
                    ),
                    AppTextFormField(
                      title: AppStrings.mobile,
                      hintText: AppStrings.enterMobile,
                      controller: mobileController,
                      keyboardType: TextInputType.phone,
                      maxLength: 10,
                    ),
                    SizedBox(
                      height: 35.h,
                    ),
                    AppTextButton(
                      title: AppStrings.getOTP,
                      onPressed: () async {
                        if(isValidate()) {
                          final responseModel = await forgotPasswordController.forgotPassword(mobile: mobileController.text);
                          if (responseModel.status ?? false) {
                            Get.toNamed(AppRoutes.verifyOtp, arguments: [
                              mobileController.text,
                              FromVerifyOTPType.forgotPassword
                            ]);

                          } else {
                            UtilityHelper.instance.showError(
                                AppStrings.error, responseModel.message ?? '');
                          }
                        }
                      },
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
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
    if (mobileController.text.isEmpty) {
      UtilityHelper.instance
          .showError(AppStrings.error, AppStrings.validateMobile);
      return false;
    } else if (mobileController.text.length != 10) {
      UtilityHelper.instance
          .showError(AppStrings.error, AppStrings.validateMobileLength);
      return false;
    }
    return true;
  }
}
