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
import 'package:inquiryapp/screens/change_password/controller/change_password_controller.dart';
import 'package:inquiryapp/screens/signin/controller/signin_controller.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final ChangePasswordController changePasswordController = Get.put(ChangePasswordController());
  final SignInDataController signInDataController = Get.put(SignInDataController());

  var isOldPasswordVisible = false;
  var isNewPasswordVisible = false;
  var isConfirmPasswordVisible = false;
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
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
                        AppStrings.changePasswordTitle,
                        style: AppTextStyle.instance.semiBoldBlack27,
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        AppStrings.changePasswordDescText,
                        style: AppTextStyle.instance.lightGrey16,
                      ),
                      SizedBox(
                        height: 35.h,
                      ),
                      AppTextFormField(
                          title: AppStrings.oldPassword,
                          hintText: AppStrings.oldEnterPassword,
                          controller: oldPasswordController,
                          obscureText: !isOldPasswordVisible,
                          suffixIcon: IconButton(
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            icon: Icon(
                              isOldPasswordVisible
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: AppColors.black,
                            ),
                            onPressed: () {
                              setState(() {
                                isOldPasswordVisible = !isOldPasswordVisible;
                              });
                            },
                          )),
                      SizedBox(
                        height: 20.h,
                      ),
                      AppTextFormField(
                          title: AppStrings.newPassword,
                          hintText: AppStrings.newEnterPassword,
                          controller: newPasswordController,
                          obscureText: !isNewPasswordVisible,
                          suffixIcon: IconButton(
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            icon: Icon(
                              isNewPasswordVisible
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: AppColors.black,
                            ),
                            onPressed: () {
                              setState(() {
                                isNewPasswordVisible = !isNewPasswordVisible;
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
                      title: AppStrings.updatePassword,
                      onPressed: () async {
                        if(isValidate()) {
                          final responseModel = await changePasswordController.changePassword(oldPassword: oldPasswordController.text, newPassword: newPasswordController.text, confirmPassword: confirmPasswordController.text);

                          if (responseModel.status ?? false) {


                            //Success Screen
                            Get.toNamed(AppRoutes.successScreen, arguments: [
                              AppStrings.successful,
                              responseModel.message ?? '',
                              false,
                              AppColors.white,
                              false,
                              FromSuccessType.changePassword,
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
    if (oldPasswordController.text.isEmpty) {
      UtilityHelper.instance
          .showError(AppStrings.error, AppStrings.validateOldPassword);
      return false;
    } else if (newPasswordController.text.isEmpty) {
      UtilityHelper.instance
          .showError(AppStrings.error, AppStrings.validateNewPassword);
      return false;
    } else if (oldPasswordController.text == newPasswordController.text) {
      UtilityHelper.instance
          .showError(AppStrings.error, AppStrings.validateOldPasswordMatch);
      return false;
    } else if (confirmPasswordController.text.isEmpty) {
      UtilityHelper.instance
          .showError(AppStrings.error, AppStrings.validateConfirmPassword);
      return false;
    } else if (newPasswordController.text != confirmPasswordController.text) {
      UtilityHelper.instance
          .showError(AppStrings.error, AppStrings.validatePasswordMatch);
      return false;
    }
    return true;
  }
}
