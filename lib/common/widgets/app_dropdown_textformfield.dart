import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inquiryapp/common/app_colors.dart';
import 'package:inquiryapp/common/app_textstyle.dart';
import 'package:inquiryapp/screens/signup/model/business_category_model.dart';

class AppDropDownTextFormField extends StatelessWidget {
  const AppDropDownTextFormField(
      {super.key,
        required this.title,
        required this.hintText,
        required this.controller,
        this.suffixIcon,
        this.obscureText = false,
        this.suffixConstrain,
        this.keyboardType,
        this.validator, this.maxLength, this.categories});

  final String title;
  final String hintText;
  final dynamic controller;
  final Widget? suffixIcon;
  final BoxConstraints? suffixConstrain;
  final bool obscureText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final int? maxLength;
  final List<Category>? categories;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.textFieldBorderColor)),
      padding: const EdgeInsets.only(top: 20, bottom: 0).r,
      child: DropDownTextField(
        // initialValue: "name4",
        controller: controller,
        clearOption: true,
        searchDecoration: const InputDecoration(
            hintText: "enter your custom hint text here"),
        validator: (value) {
          if (value == null) {
            return "Required field";
          } else {
            return null;
          }
        },
        dropDownItemCount: categories?.length ?? 0,
        clearIconProperty: IconProperty(color: Colors.black),
        dropDownIconProperty: IconProperty(color: Colors.black,size: 40,icon: Icons.arrow_drop_down),
          textFieldDecoration: InputDecoration(
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
        dropDownList: categories?.map((e) => DropDownValueModel(name: e.name ?? '', value: e.id)).toList() ?? [],
        onChanged: (val) {},
      )
    );
  }

  OutlineInputBorder textFieldBorder() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide.none);
  }
}