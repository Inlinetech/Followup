import 'package:flutter/gestures.dart';
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
import 'package:inquiryapp/common/shared_pref_helper.dart';
import 'package:inquiryapp/common/utillity_helper.dart';
import 'package:inquiryapp/common/widgets/app_text_button.dart';
import 'package:inquiryapp/common/widgets/app_text_form_field.dart';
import 'package:inquiryapp/screens/signin/controller/signin_controller.dart';
import 'package:inquiryapp/screens/signin/model/signin_data_model.dart';
import 'package:url_launcher/url_launcher.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({Key? key}) : super(key: key);

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  var isPasswordVisible = false;
  final SignInDataController signInDataController = Get.put(SignInDataController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(
              children: [
                SizedBox(
                    height: 260.h,
                    width: 1.sw,
                    child: Image.asset(
                      AppImage.signinBackgroundImage,
                      fit: BoxFit.fill,
                    )),
                SizedBox(
                    height: 260.h,
                    width: 1.sw,
                    child: Center(
                        child: Text(AppStrings.signInLogoText,
                            style: AppTextStyle.instance.semiBoldWhite34))),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15).r,
              child: Column(
                children: [
                  SizedBox(
                    height: 44.h,
                  ),
                  Text(
                    AppStrings.signin,
                    style: AppTextStyle.instance.semiBoldBlack33,
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                  Text(
                    AppStrings.enterDetails,
                    style: AppTextStyle.instance.lightGrey16,
                  ),
                  SizedBox(
                    height: 34.h,
                  ),
                  AppTextFormField(
                      title: AppStrings.userName,
                      hintText: AppStrings.enterUserName,
                      controller: userNameController,
                      suffixConstrain: const BoxConstraints(
                          maxHeight: 35.5, maxWidth: 32.5),
                      suffixIcon: Padding(
                        padding:
                            const EdgeInsets.only(bottom: 15, right: 15).r,
                        child: SvgPicture.asset(
                          AppImage.iconUser,
                          fit: BoxFit.fitHeight,
                        ),
                      )),
                  SizedBox(height: 22.h),
                  AppTextFormField(
                      title: AppStrings.password,
                      hintText: AppStrings.enterPassword,
                      controller: passwordController,
                      obscureText: !isPasswordVisible,
                      textInputAction: TextInputAction.done,
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
                  SizedBox(height: 15.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(AppRoutes.forgotPassword);
                        },
                        child: Text(
                          AppStrings.forgotPassword,
                          style: AppTextStyle.instance.lightGrey16,
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 22.h),
                  AppTextButton(
                    title: AppStrings.signin,
                    onPressed: () async {

                      if (isValidate()) {
                        final responseModel = await signInDataController.userLogin(userName: userNameController.text.trim(), password: passwordController.text.trim());
                        if (!(responseModel.status ?? false)) {
                          if ((responseModel.message ?? '').toLowerCase() == "Please verify mobile first".toLowerCase()) {
                            // Get.offNamed(AppRoutes.verifyOtp, arguments: [
                            //   '',
                            //   FromVerifyOTPType.login
                            // ]);
                            UtilityHelper.instance
                                .showError(AppStrings.error, responseModel.message ?? '');
                          } else {
                            UtilityHelper.instance
                                .showError(AppStrings.error, responseModel.message ?? '');
                          }
                        } else {
                          if (responseModel.data != null) {
                            signInDataController.setUserDataModel(responseModel.data!);
                          }


                          //Success Screen
                          Get.toNamed(AppRoutes.successScreen, arguments: [
                            AppStrings.successful,
                            responseModel.message ?? '',
                            false,
                            AppColors.primary,
                            true,
                            FromSuccessType.login,
                            false
                          ]);
                        }
                      }

                    },
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    child: Center(
                        child: Text.rich(
                            TextSpan(
                                text: 'By continuing, you agree to our ', style: AppTextStyle.instance.lightGrey14,
                                children: <TextSpan>[
                                  TextSpan(
                                      text: 'Terms of Service', style: AppTextStyle.instance.lightGrey14,
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          // code to open / launch terms of service link here
                                        }
                                  ),
                                  TextSpan(
                                      text: ' and ', style: AppTextStyle.instance.lightGrey14,
                                      children: <TextSpan>[
                                        TextSpan(
                                            text: 'Privacy Policy', style: const TextStyle(
                                            fontSize: 14, color: AppColors.primary,
                                            decoration: TextDecoration.underline
                                        ),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                launchUrl(Uri.parse('https://followuplead.com/privacy-policy'));
                                              }
                                        )
                                      ]
                                  )
                                ]
                            )
                        )
                    ),
                  ),
                  SizedBox(height: 29.h),
                  RichText(
                    text: TextSpan(
                        text: AppStrings.dontHaveAccountText,
                        style: AppTextStyle.instance.lightBlack16,
                        children: [
                          TextSpan(
                            text: AppStrings.signup,
                            style: AppTextStyle.instance.regularBlue16,
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => Get.toNamed(AppRoutes.signup),
                          )
                        ]),
                  ),
                  SizedBox(height: 29.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool isValidate() {
    if (userNameController.text.trim().isEmpty) {
      UtilityHelper.instance
          .showError(AppStrings.error, AppStrings.validateUsername);
      return false;
    } else if (passwordController.text.trim().isEmpty) {
      UtilityHelper.instance
          .showError(AppStrings.error, AppStrings.validatePassword);
      return false;
    }
    return true;
  }
}
