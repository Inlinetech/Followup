import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inquiryapp/common/app_colors.dart';

class AppTextStyle {

  AppTextStyle._privateConstructor();

  static final AppTextStyle instance = AppTextStyle._privateConstructor();

  //Signin

  //-------------------------------Semi Bold------------------------------

  //White
  final semiBoldWhite12 = TextStyle(color: AppColors.white,fontSize: 12.sp,fontWeight: FontWeight.w600);
  final semiBoldWhite16 = TextStyle(color: AppColors.white,fontSize: 16.sp,fontWeight: FontWeight.w600);
  final semiBoldWhite27 = TextStyle(color: AppColors.white,fontSize: 27.sp,fontWeight: FontWeight.w600);
  final semiBoldWhite34 = TextStyle(color: AppColors.white,fontSize: 34.sp,fontWeight: FontWeight.w600);
  final semiBoldBlue16 = TextStyle(color: AppColors.primary,fontSize: 16.sp,fontWeight: FontWeight.w600);

  //Black
  final semiBoldBlack12 = TextStyle(color: AppColors.black,fontSize: 12.sp,fontWeight: FontWeight.w600);
  final semiBoldBlack14 = TextStyle(color: AppColors.black,fontSize: 14.sp,fontWeight: FontWeight.w600);
  final semiBoldBlack16 = TextStyle(color: AppColors.black,fontSize: 16.sp,fontWeight: FontWeight.w600);
  final semiBoldBlack18 = TextStyle(color: AppColors.black,fontSize: 18.sp,fontWeight: FontWeight.w600);
  final semiBoldBlack27 = TextStyle(color: AppColors.black,fontSize: 27.sp,fontWeight: FontWeight.bold);
  final semiBoldBlack20 = TextStyle(color: AppColors.black,fontSize: 20.sp,fontWeight: FontWeight.bold);
  final semiBoldBlack33 = TextStyle(color: AppColors.black,fontSize: 33.sp,fontWeight: FontWeight.w600);

  final semiBoldGrey20 = TextStyle(color: AppColors.grey,fontSize: 20.sp,fontWeight: FontWeight.bold);
  final semiBoldGrey16 = TextStyle(color: AppColors.grey,fontSize: 16.sp,fontWeight: FontWeight.w600);
  //-------------------------------Light------------------------------
  //White
  final lightWhite17 = TextStyle(color: AppColors.white,fontSize: 17.sp,fontWeight: FontWeight.w300);
  final lightWhite14 = TextStyle(color: AppColors.white,fontSize: 14.sp,fontWeight: FontWeight.w300);
  //Black
  final lightBlack12 = TextStyle(color: AppColors.black,fontSize: 12.sp,fontWeight: FontWeight.w300);
  final lightBlack14 = TextStyle(color: AppColors.black,fontSize: 14.sp,fontWeight: FontWeight.w300);
  final lightBlack16 = TextStyle(color: AppColors.black,fontSize: 16.sp,fontWeight: FontWeight.w300);
  final lightBlack17 = TextStyle(color: AppColors.black,fontSize: 17.sp,fontWeight: FontWeight.w300);

  //Grey
  final lightGrey12 = TextStyle(color: AppColors.grey85,fontSize: 12.sp,fontWeight: FontWeight.w300);
  final lightGrey14 = TextStyle(color: AppColors.grey,fontSize: 14.sp,fontWeight: FontWeight.w300);
  final lightGreyUndeline14 = TextStyle(color: AppColors.grey,fontSize: 14.sp,fontWeight: FontWeight.w300,decoration: TextDecoration.underline);
  final lightGrey16 = TextStyle(color: AppColors.grey,fontSize: 16.sp,fontWeight: FontWeight.w300);
  final lightGrey18 = TextStyle(color: AppColors.grey,fontSize: 18.sp,fontWeight: FontWeight.w300);

//-------------------------------Regular------------------------------
  final regularBlue16 = TextStyle(color: AppColors.primary,fontSize: 16.sp,fontWeight: FontWeight.normal);
  final regularBlack16 = TextStyle(color: AppColors.black,fontSize: 16.sp,fontWeight: FontWeight.normal);
  final regularGreen12 = TextStyle(color: AppColors.lightGreen,fontSize: 12.sp,fontWeight: FontWeight.normal);
  final regularWhite12 = TextStyle(color: AppColors.white,fontSize: 12.sp,fontWeight: FontWeight.normal);
  final regularBlack12 = TextStyle(color: AppColors.black,fontSize: 12.sp,fontWeight: FontWeight.normal);
  final regularBlack14 = TextStyle(color: AppColors.black,fontSize: 14.sp,fontWeight: FontWeight.normal);
  final regularGrey14 = TextStyle(color: AppColors.grey,fontSize: 14.sp,fontWeight: FontWeight.normal);
}