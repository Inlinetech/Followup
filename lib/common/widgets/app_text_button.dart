import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inquiryapp/common/app_colors.dart';
import 'package:inquiryapp/common/app_textstyle.dart';
import 'package:lottie/lottie.dart';

class AppTextButton extends StatelessWidget {
  const AppTextButton({
    super.key,
    required this.title,
    this.onPressed,
    this.backgroundColor = AppColors.primary,
    this.side = BorderSide.none,
    this.titleStyle,
    this.alignment = Alignment.center,
    this.onlyBorder = false,
    this.borderColor,
  });

  final String title;
  final TextStyle? titleStyle;
  final Color backgroundColor;
  final BorderSide side;
  final void Function()? onPressed;
  final AlignmentGeometry alignment;
  final bool onlyBorder;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 1.sw,
      height: 52.h,
      child: TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
            backgroundColor: backgroundColor,
            shape: RoundedRectangleBorder(
                side: side,
                borderRadius: const BorderRadius.all(Radius.circular(10),)),
          ),
          child: Align(
            alignment: alignment,
            child: Text(
              title,
              style: titleStyle ?? AppTextStyle.instance.semiBoldWhite16,
            ),
          )),
    );
  }
}

class AppTextAnimationButton extends StatelessWidget {
  const AppTextAnimationButton({
    super.key,
    required this.title,
    this.onPressed,
    this.backgroundColor = AppColors.primary,
    this.side = BorderSide.none,
    this.titleStyle,
    this.onlyBorder = false,
    this.borderColor, required this.lottieBuilder,
  });

  final String title;
  final TextStyle? titleStyle;
  final Color backgroundColor;
  final BorderSide side;
  final void Function()? onPressed;
  final bool onlyBorder;
  final Color? borderColor;
  final LottieBuilder lottieBuilder;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 1.sw,
      height: 52.h,
      child: TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
            backgroundColor: backgroundColor,
            shape: RoundedRectangleBorder(
                side: side,
                borderRadius: const BorderRadius.all(Radius.circular(10),)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 15.w,),
              Text(
                title,
                style: titleStyle ?? AppTextStyle.instance.semiBoldWhite16,
              ),
              SizedBox(width: 10.w,),
              lottieBuilder
            ],
          )),
    );
  }
}