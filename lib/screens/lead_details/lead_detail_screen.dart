import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:inquiryapp/common/app_colors.dart';
import 'package:inquiryapp/common/app_enums.dart';
import 'package:inquiryapp/common/app_image.dart';
import 'package:inquiryapp/common/app_routes.dart';
import 'package:inquiryapp/common/app_strings.dart';
import 'package:inquiryapp/common/app_textstyle.dart';
import 'package:inquiryapp/common/base_data_model.dart';
import 'package:inquiryapp/common/utillity_helper.dart';
import 'package:inquiryapp/common/widgets/app_text_button.dart';
import 'package:inquiryapp/screens/home/controller/home_controller.dart';
import 'package:inquiryapp/screens/home/model/lead_data_model.dart';
import 'package:inquiryapp/screens/lead_details/controller/lead_detail_controller.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

class LeadDetailsScreen extends StatefulWidget {
  LeadDetailsScreen({super.key, required this.leadDataModel});

  LeadDataModel leadDataModel;

  @override
  State<LeadDetailsScreen> createState() => _LeadDetailsScreenState();
}

class _LeadDetailsScreenState extends State<LeadDetailsScreen> {
  final LeadDetailsController leadDetailsController =
      Get.put(LeadDetailsController());
  final HomeDataController homeDataController =
  Get.put(HomeDataController());
  bool isRemindEnable = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      isRemindEnable = widget.leadDataModel.reminderStatus == '1';
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
              Padding(
                padding: const EdgeInsets.only(top: 20).r,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: SvgPicture.asset(AppImage.iconBackLightBorder),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.leadDataModel.leadName ?? '',
                              style: AppTextStyle.instance.semiBoldBlack16,
                            ),
                            Text(
                              widget.leadDataModel.mobile ?? '',
                              style: AppTextStyle.instance.lightBlack14,
                            )
                          ],
                        )
                      ],
                    ),
                    PopupMenuButton(
                        onSelected: (value) {
                          _showRemoveAlert(context, value);
                        },
                        itemBuilder: (BuildContext bc) {
                          return [
                            PopupMenuItem(
                                value: '1',
                                child: Row(
                                  children: [
                                    SvgPicture.asset(AppImage.iconMarkAsFroud),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    Text((widget.leadDataModel.isFroud ?? '0') == '0' ? "Mark as Froud Lead" : "Remove from Froud Lead",
                                        style: AppTextStyle
                                            .instance.regularBlack14)
                                  ],
                                )),
                            PopupMenuItem(
                              value: '2',
                              child: Row(
                                children: [
                                  SvgPicture.asset(AppImage.iconRemove),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  Text("Remove Lead",
                                      style:
                                          AppTextStyle.instance.regularBlack14)
                                ],
                              ),
                            ),
                          ];
                        },
                        padding: EdgeInsets.zero)
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        height: 15.h,
                      ),
                      if (widget.leadDataModel.notes != '')
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                padding: const EdgeInsets.all(8).r,
                                decoration: BoxDecoration(
                                    color: AppColors.lightGreenOpacity,
                                    borderRadius: BorderRadius.circular(6)),
                                child: Text(
                                  'Notes: ${widget.leadDataModel.notes}',
                                  style: AppTextStyle.instance.regularGreen12,
                                )),
                            SizedBox(
                              height: 20.h,
                            ),
                          ],
                        ),
                      buildHeaderWidget("Basic Details"),
                      SizedBox(
                        height: 20.h,
                      ),
                      buildSubTitleWidget(
                          "Address", widget.leadDataModel.fullAddress ?? ''),
                      SizedBox(
                        height: 20.h,
                      ),
                      buildSubTitleWidget(
                          "Landmark", widget.leadDataModel.landmark ?? ''),
                      SizedBox(
                        height: 20.h,
                      ),
                      buildSubTitleWidget(
                          "Shop Name", widget.leadDataModel.shopName ?? ''),
                      SizedBox(
                        height: 20.h,
                      ),
                      buildHeaderWidget("Contact Details"),
                      SizedBox(
                        height: 20.h,
                      ),
                      buildSubTitleWidget(
                          "Mobile Nuber", widget.leadDataModel.mobile ?? ''),
                      SizedBox(
                        height: 20.h,
                      ),
                      const Divider(
                        color: Color(0x70707063),
                        height: 1,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          buildSubTitleWidget("Remined Me", getRemindMeText()),
                          FlutterSwitch(
                            width: 36.0,
                            height: 21.0,
                            toggleSize: 12.0,
                            value: isRemindEnable,
                            borderRadius: 20.0,
                            activeColor: const Color(0xff20946A),
                            activeToggleColor: const Color(0xffBEBEBE),
                            showOnOff: false,
                            onToggle: (val) async {
                              setState(() {
                                isRemindEnable = val;
                              });
                              final responseModel = await leadDetailsController.reminderStatus(id: widget.leadDataModel.id ?? '', action: val ? '1' : '2');
                              if (responseModel.status ?? false) {
                                homeDataController.updateLeadById(responseModel.data);
                              }
                            },
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Column(
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(bottom: 10, left: 10, right: 10),
                    child: Row(
                      children: [
                        Expanded(
                            child: AppTextButton(
                          title: AppStrings.chat,
                          side: const BorderSide(color: Color(0xff4E4E4E)),
                          backgroundColor: Colors.white,
                          titleStyle: AppTextStyle.instance.lightGrey14,
                          onPressed: () async {
                            var number = widget.leadDataModel.mobile ?? '';
                            number.substring(number.length - 10);
                            var whatsapp = "+91$number";
                            var whatsappAndroid =Uri.parse("whatsapp://send?phone=$whatsapp&text=");
                            if (await canLaunchUrl(whatsappAndroid)) {
                            await launchUrl(whatsappAndroid);
                            } else {
                              UtilityHelper.instance.showError("Error", "WhatsApp is not installed on the device");
                            }
                          },
                        )),
                        SizedBox(
                          width: 15.w,
                        ),
                        Expanded(
                            child: AppTextAnimationButton(
                          titleStyle: AppTextStyle.instance.lightWhite14,
                          title: AppStrings.callNow,
                          lottieBuilder:
                              Lottie.asset(AppImage.iconCallAnimation),
                          onPressed: () {
                            UtilityHelper.instance.makePhoneCall(
                                widget.leadDataModel.mobile ?? '');
                          },
                        ))
                      ],
                    ),
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

  String getRemindMeText() {
    if (widget.leadDataModel.reminderType == '1') {
      return 'Every Week';
    } else if (widget.leadDataModel.reminderType == '2') {
      return 'Everyday';
    } else if (widget.leadDataModel.reminderType == '3') {
      return widget.leadDataModel.specificDate ?? '';
    }
    return '';
  }

  Column buildHeaderWidget(String headerTitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          headerTitle,
          style: AppTextStyle.instance.regularBlack14,
        ),
        SizedBox(
          height: 10.h,
        ),
        const Divider(
          color: Color(0x70707063),
          height: 1,
        )
      ],
    );
  }

  Column buildSubTitleWidget(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyle.instance.regularGrey14,
        ),
        SizedBox(
          height: 5.h,
        ),
        Text(
          value,
          style: AppTextStyle.instance.semiBoldBlack14,
        ),
      ],
    );
  }

  void _showRemoveAlert(BuildContext context, String value) {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15))),
          content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return SizedBox(
              width: 1.sw,
              height: 0.3.sh,
              child: Column(
                children: [
                  SizedBox(
                    height: 35.h,
                  ),
                  SvgPicture.asset(AppImage.iconRemoveRound),
                  SizedBox(
                    height: 15.h,
                  ),
                  Text(
                    AppStrings.areYouSure,
                    style: AppTextStyle.instance.semiBoldBlack20,
                  ),
                  SizedBox(
                    height: 18.h,
                  ),
                  Text(
                    value == '1'
                        ? (widget.leadDataModel.isFroud ?? '0') == '0' ? AppStrings.markAsFraudDesc : AppStrings.removeFromFraudDesc
                        : AppStrings.removeInquiryDesc,
                    style: AppTextStyle.instance.lightGrey16,
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            );
          }),
          titleTextStyle: const TextStyle(
              fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),
          actionsOverflowButtonSpacing: 0,
          actions: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
              child: Row(
                children: [
                  Expanded(
                      child: AppTextButton(
                    title: AppStrings.cancel,
                    side: const BorderSide(color: Color(0xff4E4E4E)),
                    backgroundColor: Colors.white,
                    titleStyle: AppTextStyle.instance.lightGrey14,
                    onPressed: () {
                      Get.back();
                    },
                  )),
                  SizedBox(
                    width: 15.w,
                  ),
                  Expanded(
                      child: AppTextButton(
                    titleStyle: AppTextStyle.instance.lightWhite14,
                    backgroundColor: AppColors.darkRed,
                    title: AppStrings.yesRemove,
                    onPressed: () async {

                      if (value == '1') {
                        final responseModel = await leadDetailsController.markAsFraud(
                            id: widget.leadDataModel.id ?? '',action: (widget.leadDataModel.isFroud ?? '0') == '0' ? '1' : '2');

                        if (responseModel.status ?? false) {
                          if (responseModel.data != null) {
                            widget.leadDataModel = responseModel.data!;
                          }
                          homeDataController.updateLeadById(responseModel.data);
                        }

                        redirectBasedOnResponse(responseModel.status ?? false,responseModel.message ?? '',value);

                      } else {
                        final responseModel = await leadDetailsController.deleteLead(
                            id: widget.leadDataModel.id ?? '');

                        redirectBasedOnResponse(responseModel.status ?? false,responseModel.message ?? '',value);
                      }


                    },
                  ))
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  void redirectBasedOnResponse(bool status,String message,String value) {
    if (status) {
      Get.back();
      //Success Screen
      Get.toNamed(AppRoutes.successScreen, arguments: [
        AppStrings.successful,
        message,
        false,
        AppColors.white,
        false,
        value == '1' ? FromSuccessType.leadDetails : FromSuccessType.leadDetailsDelete,
        true
      ]);
    } else {
      UtilityHelper.instance.showError(
          AppStrings.error, message);
    }
  }
}
