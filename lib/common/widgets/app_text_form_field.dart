import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inquiryapp/common/app_colors.dart';
import 'package:inquiryapp/common/app_textstyle.dart';

class AppTextFormField extends StatelessWidget {
  const AppTextFormField(
      {super.key,
      required this.title,
      required this.hintText,
      required this.controller,
      this.suffixIcon,
      this.obscureText = false,
      this.suffixConstrain,
      this.keyboardType,
      this.validator,
      this.maxLength,
      this.readOnly = false,
      this.onTap, this.textInputAction = TextInputAction.next});

  final String title;
  final String hintText;
  final TextEditingController controller;
  final Widget? suffixIcon;
  final BoxConstraints? suffixConstrain;
  final bool obscureText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final int? maxLength;
  final bool readOnly;
  final Function()? onTap;
  final TextInputAction? textInputAction;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.textFieldBorderColor)),
      padding: const EdgeInsets.only(top: 20, bottom: 0).r,
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        maxLength: maxLength,
        readOnly: readOnly,
        onTap: onTap,
        style: AppTextStyle.instance.semiBoldBlack18,
        validator: validator,
        decoration: InputDecoration(
            counterText: "",
            suffixIcon: suffixIcon,
            suffixIconConstraints: suffixConstrain,
            contentPadding: const EdgeInsets.symmetric(horizontal: 15).r,
            labelText: title,
            fillColor: Colors.white,
            hintText: hintText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            labelStyle: AppTextStyle.instance.lightGrey18,
            hintStyle: AppTextStyle.instance.lightGrey16,
            floatingLabelStyle: AppTextStyle.instance.lightGrey18,
            focusedBorder: textFieldBorder(),
            enabledBorder: textFieldBorder(),
            errorBorder: textFieldBorder(),
            border: textFieldBorder(),
            disabledBorder: textFieldBorder(),
            focusedErrorBorder: textFieldBorder()),
      ),
    );
  }

  OutlineInputBorder textFieldBorder() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide.none);
  }
}

class AppTextViewField extends StatelessWidget {
  const AppTextViewField(
      {super.key,
      required this.hintText,
      required this.controller,
      this.suffixIcon,
      this.obscureText = false,
      this.suffixConstrain,
      this.keyboardType,
      this.validator,
      this.maxLength,
      this.readOnly = false,
      this.onTap});

  final String hintText;
  final TextEditingController controller;
  final Widget? suffixIcon;
  final BoxConstraints? suffixConstrain;
  final bool obscureText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final int? maxLength;
  final bool readOnly;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150.h,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.textFieldBorderColor)),
      padding: const EdgeInsets.only(top: 20, bottom: 0).r,
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,

        maxLength: maxLength,
        readOnly: readOnly,
        onTap: onTap,
        style: AppTextStyle.instance.semiBoldBlack18,
        validator: validator,
        keyboardType: TextInputType.multiline,
        minLines: 1,
        //Normal textInputField will be displayed
        maxLines: 5,
        decoration: InputDecoration(
            counterText: "",
            isDense: true,
            suffixIcon: suffixIcon,
            suffixIconConstraints: suffixConstrain,
            contentPadding: const EdgeInsets.symmetric(horizontal: 15).r,
            fillColor: Colors.white,
            hintText: hintText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintStyle: AppTextStyle.instance.lightGrey16,
            floatingLabelStyle: AppTextStyle.instance.lightGrey18,
            focusedBorder: textFieldBorder(),
            enabledBorder: textFieldBorder(),
            errorBorder: textFieldBorder(),
            border: textFieldBorder(),
            disabledBorder: textFieldBorder(),
            focusedErrorBorder: textFieldBorder()),
      ),
    );
  }

  OutlineInputBorder textFieldBorder() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide.none);
  }
}
