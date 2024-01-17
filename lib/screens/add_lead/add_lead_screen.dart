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
import 'package:inquiryapp/screens/add_lead/controller/add_lead_controller.dart';

class AddLeadScreen extends StatefulWidget {
  const AddLeadScreen({super.key});

  @override
  State<AddLeadScreen> createState() => _AddLeadScreenState();
}

class _AddLeadScreenState extends State<AddLeadScreen> {
  final AddLeadDataController addLeadDataController = Get.put(AddLeadDataController());

  final TextEditingController leadNameController = TextEditingController();
  final TextEditingController flatNumberController = TextEditingController();
  final TextEditingController areaNameController = TextEditingController();
  final TextEditingController pinCodeController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController landMarkController = TextEditingController();
  final TextEditingController shopNameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController notesController = TextEditingController();
  final TextEditingController customMessageController = TextEditingController();

  final SingleValueDropDownController classTypeController =
      SingleValueDropDownController();
  String? radioSelection;
  DateTime? selectedDay;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      addLeadDataController.getLeadCategories();
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
                  padding: const EdgeInsets.only(top: 20).r,
                  child: SvgPicture.asset(AppImage.iconBackLightBorder),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        height: 20.h,
                      ),
                      Text(
                        AppStrings.addleadTitle,
                        style: AppTextStyle.instance.semiBoldBlack20,
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        AppStrings.addleadDescText,
                        style: AppTextStyle.instance.lightGrey16,
                      ),
                      SizedBox(
                        height: 35.h,
                      ),
                      GetBuilder<AddLeadDataController>(
                        builder: (addLeadDataController) {
                          return AppDropDownTextFormField(
                              title: AppStrings.classType,
                              hintText: AppStrings.selectClassType,
                              controller: classTypeController,categories: addLeadDataController.leadCategory,);
                        }
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      AppTextFormField(
                          title: AppStrings.leadName,
                          hintText: AppStrings.enterLeadName,
                          controller: leadNameController,
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
                      SizedBox(
                        height: 20.h,
                      ),
                      AppTextFormField(
                        title: AppStrings.flatNumber,
                        hintText: AppStrings.enterFlatNumber,
                        controller: flatNumberController,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      AppTextFormField(
                        title: AppStrings.areaName,
                        hintText: AppStrings.enterAreaName,
                        controller: areaNameController,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: AppTextFormField(
                              title: AppStrings.pinCode,
                              hintText: AppStrings.enterPinCode,
                              controller: pinCodeController,
                            ),
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
                          Expanded(
                            child: AppTextFormField(
                              title: AppStrings.city,
                              hintText: AppStrings.enterCity,
                              controller: cityController,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      AppTextFormField(
                        title: AppStrings.landMark,
                        hintText: AppStrings.enterLandMark,
                        controller: landMarkController,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      AppTextFormField(
                        title: AppStrings.shopName,
                        hintText: AppStrings.enterShopName,
                        controller: shopNameController,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      AppTextFormField(
                        title: AppStrings.mobile,
                        hintText: AppStrings.enterMobile,
                        controller: mobileController,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Text(AppStrings.notes,style:  AppTextStyle.instance.lightGrey16,),
                      SizedBox(
                        height: 10.h,
                      ),
                      AppTextViewField(
                        hintText: AppStrings.enterNotes,
                        controller: notesController,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Text(AppStrings.addCustomMessage,style:  AppTextStyle.instance.lightGrey16,),
                      SizedBox(
                        height: 10.h,
                      ),
                      AppTextViewField(
                        hintText: AppStrings.enterCustomMessage,
                        controller: customMessageController,
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
                        child: GestureDetector(
                          onTap: onReminderTap,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 5.w,
                              ),
                              SvgPicture.asset(
                                radioSelection == null ? AppImage.iconUnChecked : AppImage.iconChecked,
                                width: 20,
                                height: 20,
                              ),
                              const SizedBox(width: 8,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(AppStrings.remindMe,style: AppTextStyle.instance.lightBlack16,),
                                  if (selectedDay != null)
                                    Text(UtilityHelper.instance.convertDateToString(selectedDay!, "dd/MM/yyyy"),style: AppTextStyle.instance.lightGrey14,)
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      Expanded(
                        child: AppTextButton(
                          title: AppStrings.addInquiry,
                          onPressed: () async {
                            if (isValidate()) {

                              final response = await addLeadDataController.createLead(
                                cassTypeId: classTypeController.dropDownValue?.value,
                                leadName: leadNameController.text,
                                mobile: mobileController.text,
                                address: flatNumberController.text,
                                address1: areaNameController.text,
                                pinCode: pinCodeController.text,
                                city: cityController.text,
                                landmark: landMarkController.text,
                                shopName: shopNameController.text,
                                customMessage: customMessageController.text,
                                notes: notesController.text,
                                reminderType: radioSelection ?? '1',
                                reminderDate: selectedDay != null ? UtilityHelper.instance.convertDateToString(selectedDay!, "yyyy-MM-dd") : '',
                              );
                              if (response.status ?? false) {
                                //Success Screen
                                redirectToSuccess();
                              } else {

                                if (response.message == 'Lead Added Successfully') {
                                  //Success Screen
                                  redirectToSuccess();
                                } else {
                                  UtilityHelper.instance
                                      .showError(AppStrings.error, response.message ?? '');
                                }

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

  void redirectToSuccess() {
    Get.offNamed(AppRoutes.successScreen, arguments: [
      AppStrings.successful,
      'Customer Inquiry Successfully Added',
      false,
      AppColors.white,
      false,
      FromSuccessType.addLeads,
      false,
    ]);
  }

  bool isValidate() {
    if (classTypeController.dropDownValue == null) {
      UtilityHelper.instance
          .showError(AppStrings.error, AppStrings.validateClassType);
      return false;
    } else if (leadNameController.text.isEmpty) {
      UtilityHelper.instance
          .showError(AppStrings.error, AppStrings.validateLead);
      return false;
    }
    // else if (flatNumberController.text.isEmpty) {
    //   UtilityHelper.instance
    //       .showError(AppStrings.error, AppStrings.validateAddress);
    //   return false;
    // }
    // else if (areaNameController.text.isEmpty) {
    //   UtilityHelper.instance
    //       .showError(AppStrings.error, AppStrings.validateAddress1);
    //   return false;
    // } else if (pinCodeController.text.isEmpty) {
    //   UtilityHelper.instance
    //       .showError(AppStrings.error, AppStrings.validatePincode);
    //   return false;
    // } else if (cityController.text.isEmpty) {
    //   UtilityHelper.instance
    //       .showError(AppStrings.error, AppStrings.validateCity);
    //   return false;
    // }
    else if (mobileController.text.isEmpty) {
      UtilityHelper.instance
          .showError(AppStrings.error, AppStrings.validateMobile);
      return false;
    }
    // else if (mobileController.text.isEmpty) {
    //   UtilityHelper.instance
    //       .showError(AppStrings.error, AppStrings.validateNote);
    //   return false;
    // } else if (customMessageController.text.isEmpty) {
    //   UtilityHelper.instance
    //       .showError(AppStrings.error, AppStrings.validateCustomMessage);
    //   return false;
    // } else if (radioSelection == null) {
    //   UtilityHelper.instance
    //       .showError(AppStrings.error, AppStrings.validateRemindMe);
    //   return false;
    // }
    return true;
  }

  void onReminderTap() async {
    var result = await Get.toNamed(AppRoutes.setReminder);
    if (result != null) {
      setState(() {
        radioSelection = result[0];
        selectedDay = result[1];
      });
    }
  }
}
