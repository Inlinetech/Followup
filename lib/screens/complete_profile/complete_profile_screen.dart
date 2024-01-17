import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:inquiryapp/common/app_colors.dart';
import 'package:inquiryapp/common/app_enums.dart';
import 'package:inquiryapp/common/app_routes.dart';
import 'package:inquiryapp/common/app_strings.dart';
import 'package:inquiryapp/common/app_textstyle.dart';
import 'package:inquiryapp/common/shared_pref_helper.dart';
import 'package:inquiryapp/common/utillity_helper.dart';
import 'package:inquiryapp/common/widgets/app_dropdown_textformfield.dart';
import 'package:inquiryapp/common/widgets/app_text_button.dart';
import 'package:inquiryapp/common/widgets/app_text_form_field.dart';
import 'package:inquiryapp/screens/signin/controller/signin_controller.dart';
import 'package:inquiryapp/screens/signin/model/signin_data_model.dart';
import 'package:inquiryapp/screens/update_company_profile/controller/update_company_profile_controller.dart';

import '../signup/controller/signup_controller.dart';

class CompleteProfileScreen extends StatefulWidget {
  const CompleteProfileScreen({super.key});

  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  final SignInDataController signInDataController = Get.put(SignInDataController());
  final UpdateCompanyProfileController updateCompanyProfileController =
      Get.put(UpdateCompanyProfileController());
  final SignupDataController authController = Get.put(SignupDataController());
  final TextEditingController companyNameController = TextEditingController();
  // final TextEditingController mobileController = TextEditingController();
  // final TextEditingController emailController = TextEditingController();
  final SingleValueDropDownController businessCategoryController =
      SingleValueDropDownController();
  final SingleValueDropDownController businessTypeController =
      SingleValueDropDownController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController cityController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userDefaultToModel();
  }

  userDefaultToModel() async {
    try {
      if (SharedPref.read("user") != null) {
        final userDataModel = UserDataModel.fromJson(await SharedPref.read("user"));
        signInDataController.setUserDataModel(userDataModel);

        print("Token: ${signInDataController.user?.token}");

        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          authController.getBusinessCategories();
          authController.getBusinessTypes();
        });
      }
    } catch (Excepetion) {
      print(Excepetion);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15).r,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        height: 20.h,
                      ),
                      Text(
                        AppStrings.completeProfileTitle,
                        style: AppTextStyle.instance.semiBoldBlack20,
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        AppStrings.completeProfileDescText,
                        style: AppTextStyle.instance.lightGrey16,
                      ),
                      SizedBox(
                        height: 35.h,
                      ),
                      AppTextFormField(
                        title: AppStrings.companyName,
                        hintText: AppStrings.enterCompanyName,
                        controller: companyNameController,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      GetBuilder<SignupDataController>(
                          builder: (signupDataController) {
                        return Column(
                          children: [
                            AppDropDownTextFormField(
                              title: AppStrings.businessCategory,
                              hintText: AppStrings.selectBusinessCategory,
                              controller: businessCategoryController,
                              categories: signupDataController.businessCategory,
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            AppDropDownTextFormField(
                              title: AppStrings.businessType,
                              hintText: AppStrings.selectBusinessType,
                              controller: businessTypeController,
                              categories: signupDataController.businessTypes,
                            ),
                          ],
                        );
                      }),
                      // AppTextFormField(
                      //   title: AppStrings.emailAddress,
                      //   hintText: AppStrings.enterEmailAddress,
                      //   controller: emailController,
                      //   keyboardType: TextInputType.emailAddress,
                      // ),
                      // SizedBox(
                      //   height: 20.h,
                      // ),
                      // AppTextFormField(
                      //   title: AppStrings.mobile,
                      //   hintText: AppStrings.enterMobile,
                      //   controller: mobileController,
                      //   keyboardType: TextInputType.phone,
                      //   maxLength: 10,
                      // ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: AppTextFormField(
                                title: AppStrings.state,
                                hintText: AppStrings.selectState,
                                controller: stateController),
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
                          Expanded(
                            child: AppTextFormField(
                                title: AppStrings.city,
                                hintText: AppStrings.enterCity,
                                controller: cityController),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: AppTextButton(
                          backgroundColor: Colors.transparent,
                          title: AppStrings.skipNow,
                          titleStyle: AppTextStyle.instance.lightGrey16,
                          onPressed: () {
                            Get.offAllNamed(AppRoutes.home);
                          },
                        ),
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      Expanded(
                        child: AppTextButton(
                          title: AppStrings.submit,
                          onPressed: () async {
                            if (isValidate()) {
                              final responseModel =
                                  await updateCompanyProfileController
                                      .updateCompanyProfile(
                                          companyName: companyNameController
                                              .text,
                                          businessCategoryId:
                                              businessCategoryController
                                                      .dropDownValue?.value ??
                                                  '',
                                          businessTypeId: businessTypeController
                                                  .dropDownValue?.value ??
                                              '',
                                          state: stateController.text,
                                          city: cityController.text);

                              if (responseModel.status ?? false) {
                                //Success Screen
                                Get.toNamed(AppRoutes.successScreen,
                                    arguments: [
                                      AppStrings.successful,
                                      responseModel.message ?? '',
                                      false,
                                      AppColors.primary,
                                      true,
                                      FromSuccessType.completeProfile,
                                      false
                                    ]);
                              } else {
                                UtilityHelper.instance.showError(
                                    AppStrings.error,
                                    responseModel.message ?? '');
                              }
                            }
                          },
                        ),
                      ),
                    ],
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
    );
  }

  bool isValidate() {
    if (companyNameController.text.isEmpty) {
      UtilityHelper.instance
          .showError(AppStrings.error, AppStrings.validateCompanyName);
      return false;
    } else if (businessCategoryController.dropDownValue == null) {
      UtilityHelper.instance
          .showError(AppStrings.error, AppStrings.validateBusinessCategories);
      return false;
    } else if (businessTypeController.dropDownValue == null) {
      UtilityHelper.instance
          .showError(AppStrings.error, AppStrings.validateBusinessType);
      return false;
    }
    // else if (emailController.text.isEmpty) {
    //   UtilityHelper.instance
    //       .showError(AppStrings.error, AppStrings.validateEmail);
    //   return false;
    // } else if (!GetUtils.isEmail(emailController.text)) {
    //   UtilityHelper.instance
    //       .showError(AppStrings.error, AppStrings.validateCheckEmail);
    //   return false;
    // } else if (mobileController.text.isEmpty) {
    //   UtilityHelper.instance
    //       .showError(AppStrings.error, AppStrings.validateMobile);
    //   return false;
    // } else if (mobileController.text.length != 10) {
    //   UtilityHelper.instance
    //       .showError(AppStrings.error, AppStrings.validateMobileLength);
    //   return false;
    // }
    return true;
  }
}
