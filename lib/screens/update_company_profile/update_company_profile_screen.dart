import 'package:dropdown_textfield/dropdown_textfield.dart';
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
import 'package:inquiryapp/screens/signin/controller/signin_controller.dart';
import 'package:inquiryapp/screens/signup/controller/signup_controller.dart';
import 'package:inquiryapp/screens/update_company_profile/controller/update_company_profile_controller.dart';

class UpdateCompanyProfileScreen extends StatefulWidget {
  const UpdateCompanyProfileScreen({super.key});

  @override
  State<UpdateCompanyProfileScreen> createState() =>
      _UpdateCompanyProfileScreenState();
}

class _UpdateCompanyProfileScreenState
    extends State<UpdateCompanyProfileScreen> {
  final SignInDataController signInDataController = Get.put(SignInDataController());
  final SignupDataController signupDataController =
      Get.put(SignupDataController());
  final UpdateCompanyProfileController updateCompanyProfileController =
      Get.put(UpdateCompanyProfileController());
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
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // mobileController.text = signInDataController.user?.mobile ?? '';
      // emailController.text = signInDataController.user?.email ?? '';
      companyNameController.text = signInDataController.user?.companyName ?? '';
      stateController.text = signInDataController.user?.state ?? '';
      cityController.text = signInDataController.user?.city ?? '';
      if (signupDataController.businessCategory.isNotEmpty) {
        final name = signupDataController.getBusinessCategoryById(signInDataController.user?.businessCategoryId ?? '')?.name ?? '';
        final value = signupDataController.getBusinessCategoryById(signInDataController.user?.businessCategoryId ?? '')?.id ?? '';
        businessCategoryController.setDropDown(DropDownValueModel(name: name, value: value));
      }

      if (signupDataController.businessTypes.isNotEmpty) {
        final name = signupDataController.getBusinessTypesById(signInDataController.user?.businessTypeId ?? '')?.name ?? '';
        final value = signupDataController.getBusinessTypesById(signInDataController.user?.businessTypeId ?? '')?.id ?? '';
        businessTypeController.setDropDown(DropDownValueModel(name: name, value: value));
      }
    });
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
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15).r,
                  child: SvgPicture.asset(AppImage.iconBackLightBorder),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        AppStrings.updateCompanyProfileTitle,
                        style: AppTextStyle.instance.semiBoldBlack27,
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        AppStrings.updateCompanyProfileDescText,
                        style: AppTextStyle.instance.lightGrey16,
                      ),
                      SizedBox(
                        height: 25.h,
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
                                categories:
                                    signupDataController.businessCategory,
                                title: AppStrings.businessCategory,
                                hintText: AppStrings.selectBusinessCategory,
                                controller: businessCategoryController),
                            SizedBox(
                              height: 20.h,
                            ),
                            AppDropDownTextFormField(
                                categories: signupDataController.businessTypes,
                                title: AppStrings.businessType,
                                hintText: AppStrings.selectBusinessType,
                                controller: businessTypeController),
                            SizedBox(
                              height: 20.h,
                            ),
                          ],
                        );
                      }),
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
                          title: AppStrings.update,
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
                                      AppColors.white,
                                      false,
                                      FromSuccessType.changePassword,
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
    } else if (stateController.text.isEmpty) {
      UtilityHelper.instance
          .showError(AppStrings.error, AppStrings.validateState);
      return false;
    } else if (cityController.text.isEmpty) {
      UtilityHelper.instance
          .showError(AppStrings.error, AppStrings.validateCity);
      return false;
    }
    return true;
  }
}
