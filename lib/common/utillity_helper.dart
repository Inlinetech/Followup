import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:inquiryapp/common/app_colors.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class UtilityHelper {

  UtilityHelper._privateConstructor();

  static final UtilityHelper instance = UtilityHelper._privateConstructor();

  showSuccess(String title,String message) {
    Get.snackbar(title, message,
        colorText: AppColors.white,
        backgroundColor: AppColors.green,
        margin: const EdgeInsets.only(top: 20,left: 10,right: 10));
  }

  showError(String title,String message) {
    Get.snackbar(title, message,
        colorText: AppColors.white,
        backgroundColor: AppColors.red,
        margin: const EdgeInsets.only(top: 20,left: 10,right: 10));
  }

  showLoader() {
    EasyLoading.show(status: 'loading...',);
  }

  hideLoader() {
    EasyLoading.dismiss();
  }

  String convertDateToString(DateTime date,String dateFormat) {
    String formattedDate = DateFormat(dateFormat).format(date);
    return formattedDate;
  }

  Future<DateTime?> showDatePickerWidget(BuildContext context) {
    return showDatePicker(
      context: context,
      firstDate: DateTime(1900),
      initialDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primary, // header background color
              onPrimary: Colors.white, // header text color
              onSurface: Colors.black, // body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.black, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );
  }

  Future<DateTimeRange?> showDateRangePickerWidget(BuildContext context) {
    return showDateRangePicker(
      context: context,
      firstDate: DateTime(1900),
      currentDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primary, // header background color
              onPrimary: Colors.white, // header text color
              onSurface: Colors.black, // body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.black, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );
  }

  hideFocus() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  Future<void> launchInBrowser(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  Future<void> makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }
}