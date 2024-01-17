import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:inquiryapp/common/app_colors.dart';
import 'package:inquiryapp/common/app_enums.dart';
import 'package:inquiryapp/common/app_image.dart';
import 'package:inquiryapp/common/app_routes.dart';
import 'package:inquiryapp/common/app_strings.dart';
import 'package:inquiryapp/common/app_textstyle.dart';
import 'package:inquiryapp/common/widgets/app_text_button.dart';
import 'package:lottie/lottie.dart';

class SuccessWithMessageScreen extends StatefulWidget {
  const SuccessWithMessageScreen(
      {super.key,
      required this.title,
      required this.description,
      required this.isCompleteProfile,
      required this.backgroundColor,
      required this.isWhiteText,
      required this.successType,
      required this.isRemoveAnimation});

  final String title;
  final String description;
  final Color backgroundColor;
  final bool isWhiteText;
  final bool isCompleteProfile;
  final FromSuccessType successType;
  final bool isRemoveAnimation;

  @override
  State<SuccessWithMessageScreen> createState() =>
      _SuccessWithMessageScreenState();
}

class _SuccessWithMessageScreenState extends State<SuccessWithMessageScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(Duration(seconds: widget.isRemoveAnimation ? 5 : 4), () {
      if (widget.successType == FromSuccessType.login ||
          widget.successType == FromSuccessType.addLeads ||
          widget.successType == FromSuccessType.leadDetailsDelete || widget.successType == FromSuccessType.completeProfile) {
        Get.offAllNamed(AppRoutes.home);
      } else if (widget.successType == FromSuccessType.changePassword ||
          widget.successType == FromSuccessType.updateProfile) {
        Get.close(2);
      } else if (widget.successType == FromSuccessType.leadDetails) {
        Get.back();
      } else if (widget.successType == FromSuccessType.resetPassword) {
        Get.offAllNamed(AppRoutes.signin);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.backgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Lottie.asset(
              widget.isRemoveAnimation
                  ? AppImage.removeAnimationImage
                  : AppImage.animationImage,
              height: 0.35.sh),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20).r,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      widget.title,
                      textAlign: TextAlign.center,
                      style: widget.isWhiteText
                          ? AppTextStyle.instance.semiBoldWhite27
                          : AppTextStyle.instance.semiBoldBlack27,
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Text(
                      widget.description,
                      textAlign: TextAlign.center,
                      style: widget.isWhiteText
                          ? AppTextStyle.instance.lightWhite17
                          : AppTextStyle.instance.lightBlack17,
                    ),
                    if (widget.isCompleteProfile)
                      Column(
                        children: [
                          SizedBox(
                            height: 40.h,
                          ),
                          SizedBox(
                              width: 0.45.sw,
                              child: AppTextButton(
                                title: AppStrings.completeProfile,
                                onPressed: () {
                                  Get.offAllNamed(AppRoutes.completeProfile);
                                },
                                side: const BorderSide(
                                    width: 1, color: AppColors.white),
                              )),
                        ],
                      )
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
