import 'package:dropdown_textfield/dropdown_textfield.dart';
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
import 'package:inquiryapp/common/utillity_helper.dart';
import 'package:inquiryapp/common/widgets/app_dropdown_textformfield.dart';
import 'package:inquiryapp/common/widgets/app_text_button.dart';
import 'package:inquiryapp/common/widgets/app_text_form_field.dart';
import 'package:inquiryapp/screens/signup/controller/signup_controller.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final SignupDataController authController = Get.put(SignupDataController());
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final SingleValueDropDownController categoryController =
      SingleValueDropDownController();
  var isPasswordVisible = false;
  var isConfirmPasswordVisible = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      authController.getBusinessCategories();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, top: 0).r,
                  child: SvgPicture.asset(AppImage.iconBackBlack),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        AppStrings.signup,
                        style: AppTextStyle.instance.semiBoldBlack33,
                      ),
                      SizedBox(
                        height: 25.h,
                      ),
                      Text(
                        AppStrings.enterDetails,
                        style: AppTextStyle.instance.lightGrey16,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15).r,
                    child: Column(
                      children: [
                        AppTextFormField(
                            title: AppStrings.userName,
                            hintText: AppStrings.enterUserName,
                            controller: userNameController,
                            suffixConstrain: const BoxConstraints(
                                maxHeight: 35.5, maxWidth: 32.5),
                            suffixIcon: Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 15, right: 15)
                                      .r,
                              child: SvgPicture.asset(
                                AppImage.iconUser,
                                fit: BoxFit.fitHeight,
                              ),
                            )),
                        SizedBox(
                          height: 20.h,
                        ),
                        AppTextFormField(
                          title: AppStrings.mobile,
                          hintText: AppStrings.enterMobile,
                          controller: mobileController,
                          keyboardType: TextInputType.phone,
                          maxLength: 10,
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        AppTextFormField(
                          title: AppStrings.emailAddress,
                          hintText: AppStrings.enterEmailAddress,
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        AppTextFormField(
                            title: AppStrings.password,
                            hintText: AppStrings.enterPassword,
                            controller: passwordController,
                            obscureText: !isPasswordVisible,
                            suffixIcon: GestureDetector(
                              child: Icon(
                                isPasswordVisible
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                color: AppColors.black,
                              ),
                              onTap: () {
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
                            suffixIcon: GestureDetector(
                              child: Icon(
                                isConfirmPasswordVisible
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                color: AppColors.black,
                              ),
                              onTap: () {
                                setState(() {
                                  isConfirmPasswordVisible =
                                      !isConfirmPasswordVisible;
                                });
                              },
                            )),
                        SizedBox(
                          height: 20.h,
                        ),
                        GetBuilder<SignupDataController>(
                            builder: (authController) {
                          return AppDropDownTextFormField(
                            title: AppStrings.category,
                            hintText: AppStrings.selectCategory,
                            controller: categoryController,
                            categories: authController.businessCategory,
                          );
                        }),
                        SizedBox(
                          height: 20.h,
                        ),
                        AppTextButton(
                          title: AppStrings.signup,
                          onPressed: () async {
                            if (isValidate()) {
                              final response = await authController.addNewUser(
                                  userName: userNameController.text,
                                  email: emailController.text,
                                  mobile: mobileController.text,
                                  password: passwordController.text,
                                  businessCategoryId:
                                      categoryController.dropDownValue?.value);
                              if (response.status ?? false) {
                                Get.offNamed(AppRoutes.verifyOtp, arguments: [
                                  mobileController.text,
                                  FromVerifyOTPType.signup
                                ]);
                              } else {
                                UtilityHelper.instance.showError(
                                    AppStrings.error, response.message ?? '');
                              }
                            }
                          },
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        RichText(
                          text: TextSpan(
                              text: AppStrings.alreadyHaveAccount,
                              style: AppTextStyle.instance.lightBlack16,
                              children: [
                                TextSpan(
                                  text: AppStrings.signin,
                                  style: AppTextStyle.instance.regularBlue16,
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () => Get.back(),
                                )
                              ]),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool isValidate() {
    if (userNameController.text.isEmpty) {
      UtilityHelper.instance
          .showError(AppStrings.error, AppStrings.validateUsername);
      return false;
    } else if (mobileController.text.isEmpty) {
      UtilityHelper.instance
          .showError(AppStrings.error, AppStrings.validateMobile);
      return false;
    } else if (mobileController.text.length != 10) {
      UtilityHelper.instance
          .showError(AppStrings.error, AppStrings.validateMobileLength);
      return false;
    } else if (emailController.text.isEmpty) {
      UtilityHelper.instance
          .showError(AppStrings.error, AppStrings.validateEmail);
      return false;
    } else if (!GetUtils.isEmail(emailController.text)) {
      UtilityHelper.instance
          .showError(AppStrings.error, AppStrings.validateCheckEmail);
      return false;
    } else if (passwordController.text.isEmpty) {
      UtilityHelper.instance
          .showError(AppStrings.error, AppStrings.validatePassword);
      return false;
    } else if (confirmPasswordController.text.isEmpty) {
      UtilityHelper.instance
          .showError(AppStrings.error, AppStrings.validateConfirmPassword);
      return false;
    } else if (passwordController.text != confirmPasswordController.text) {
      UtilityHelper.instance
          .showError(AppStrings.error, AppStrings.validatePasswordMatch);
      return false;
    } else if (categoryController.dropDownValue == null) {
      UtilityHelper.instance
          .showError(AppStrings.error, AppStrings.validateBusinessCategory);
      return false;
    }
    return true;
  }
}
