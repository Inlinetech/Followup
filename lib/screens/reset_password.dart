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
import 'package:inquiryapp/common/widgets/app_text_form_field.dart';
import 'package:inquiryapp/screens/forgot_password/controller/forgot_password_controller.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key, required this.mobile});
final String mobile;
  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final ForgotPasswordController forgotPasswordController = Get.put(ForgotPasswordController());
  var isPasswordVisible = false;
  var isConfirmPasswordVisible = false;
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
  TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: 0.97.sh,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15).r,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15).r,
                      child: SvgPicture.asset(AppImage.iconBackLightBorder),
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        AppStrings.resetTitle,
                        style: AppTextStyle.instance.semiBoldBlack27,
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        AppStrings.resetDescText,
                        style: AppTextStyle.instance.lightGrey16,
                      ),
                      SizedBox(
                        height: 35.h,
                      ),
                      AppTextFormField(
                          title: AppStrings.newPassword,
                          hintText: AppStrings.newEnterPassword,
                          controller: passwordController,
                          obscureText: !isPasswordVisible,
                          suffixIcon: IconButton(
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            icon: Icon(
                              isPasswordVisible
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: AppColors.black,
                            ),
                            onPressed: () {
                              setState(() {
                                isPasswordVisible = !isPasswordVisible;
                              });
                            },
                          )),
                      SizedBox(
                        height: 20.h,
                      ),
                      AppTextFormField(
                          title: AppStrings.confirmPassword,
                          hintText: AppStrings.confirmEnterPassword,
                          controller: confirmPasswordController,
                          obscureText: !isConfirmPasswordVisible,
                          suffixIcon: IconButton(
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            icon: Icon(
                              isConfirmPasswordVisible
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: AppColors.black,
                            ),
                            onPressed: () {
                              setState(() {
                                isConfirmPasswordVisible =
                                !isConfirmPasswordVisible;
                              });
                            },
                          )),

                      SizedBox(
                        height: 35.h,
                      ),
                    ],
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20).r,
                    child: AppTextButton(
                      title: AppStrings.resetPassword,
                      onPressed: () async {
                        if (isValidate()) {
                          final responseModel = await forgotPasswordController.resetPassword(mobile: widget.mobile,password: passwordController.text,confirmPassword: confirmPasswordController.text);

                          if (responseModel.status ?? false) {
                            //Success Screen
                            Get.toNamed(AppRoutes.successScreen, arguments: [
                              AppStrings.successful,
                              responseModel.message ?? '',
                              false,
                              AppColors.primary,
                              true,
                              FromSuccessType.resetPassword,
                              false
                            ]);
                          } else {
                            UtilityHelper.instance.showError(AppStrings.error, responseModel.message ?? '');
                          }
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool isValidate() {
    if (passwordController.text.isEmpty) {
      UtilityHelper.instance
          .showError(AppStrings.error, AppStrings.validateNewPassword);
      return false;
    } else if (confirmPasswordController.text.isEmpty) {
      UtilityHelper.instance
          .showError(AppStrings.error, AppStrings.validateConfirmPassword);
      return false;
    } else if (passwordController.text != confirmPasswordController.text) {
      UtilityHelper.instance
          .showError(AppStrings.error, AppStrings.validateNewPasswordMatch);
      return false;
    }
    return true;
  }
}
