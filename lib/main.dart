import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inquiryapp/common/app_colors.dart';
import 'package:inquiryapp/common/app_routes.dart';
import 'package:inquiryapp/common/singleton_services.dart';

Future<void> main() async {
  await setup();
  final isSignIn = await isLoggedIn();
  runApp(InquiryApp(isLoggedIn: isSignIn,));
  setupAfterRunApp();
}


class InquiryApp extends StatelessWidget {
  const InquiryApp({super.key, required this.isLoggedIn});

  final bool isLoggedIn;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          theme: ThemeData(
            fontFamily: GoogleFonts.outfit().fontFamily,
            scaffoldBackgroundColor: AppColors.white
          ),
          debugShowCheckedModeBanner: false,
          initialRoute: isLoggedIn ? AppRoutes.home : AppRoutes.signin,
          getPages: getPages,
          builder: EasyLoading.init(),
        );
      },
    );
  }
}
