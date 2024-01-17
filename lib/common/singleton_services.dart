import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:inquiryapp/common/app_colors.dart';
import 'package:inquiryapp/common/network/dio_client.dart';
import 'package:inquiryapp/common/shared_pref_helper.dart';
import 'package:inquiryapp/firebase_options.dart';
import 'package:inquiryapp/screens/add_lead/api/add_lead_api.dart';
import 'package:inquiryapp/screens/add_lead/api/add_lead_repository.dart';
import 'package:inquiryapp/screens/add_lead/controller/add_lead_controller.dart';
import 'package:inquiryapp/screens/change_password/api/change_password_api.dart';
import 'package:inquiryapp/screens/change_password/api/change_password_repository.dart';
import 'package:inquiryapp/screens/change_password/controller/change_password_controller.dart';
import 'package:inquiryapp/screens/export/api/export_lead_api.dart';
import 'package:inquiryapp/screens/export/api/export_lead_repository.dart';
import 'package:inquiryapp/screens/export/controller/export_lead_controller.dart';
import 'package:inquiryapp/screens/forgot_password/api/forgot_password_api.dart';
import 'package:inquiryapp/screens/forgot_password/api/forgot_password_repository.dart';
import 'package:inquiryapp/screens/forgot_password/controller/forgot_password_controller.dart';
import 'package:inquiryapp/screens/home/api/home_api.dart';
import 'package:inquiryapp/screens/home/api/home_repository.dart';
import 'package:inquiryapp/screens/home/controller/home_controller.dart';
import 'package:inquiryapp/screens/lead_details/api/lead_detail_api.dart';
import 'package:inquiryapp/screens/lead_details/api/lead_detail_repository.dart';
import 'package:inquiryapp/screens/lead_details/controller/lead_detail_controller.dart';
import 'package:inquiryapp/screens/notification/api/notification_screen_api.dart';
import 'package:inquiryapp/screens/notification/api/notification_screen_repository.dart';
import 'package:inquiryapp/screens/notification/controller/notification_screen_controller.dart';
import 'package:inquiryapp/screens/signin/api/signin_api.dart';
import 'package:inquiryapp/screens/signin/api/signin_repository.dart';
import 'package:inquiryapp/screens/signin/controller/signin_controller.dart';
import 'package:inquiryapp/screens/signin/model/signin_data_model.dart';
import 'package:inquiryapp/screens/signup/api/signup_api.dart';
import 'package:inquiryapp/screens/signup/controller/signup_controller.dart';
import 'package:inquiryapp/screens/signup/api/signup_repository.dart';
import 'package:inquiryapp/screens/update_company_profile/api/update_company_profile_api.dart';
import 'package:inquiryapp/screens/update_company_profile/api/update_company_profile_repository.dart';
import 'package:inquiryapp/screens/update_company_profile/controller/update_company_profile_controller.dart';
import 'package:inquiryapp/screens/verifyotp/api/verifyotp_api.dart';
import 'package:inquiryapp/screens/verifyotp/api/verifyotp_repository.dart';
import 'package:inquiryapp/screens/verifyotp/controller/verifyotp_controller.dart';
import 'package:intl/date_symbol_data_local.dart';

final getIt = GetIt.instance;
Future<void> setup() async {


  //Signletone Setup
  getIt.registerSingleton(Dio());
  getIt.registerSingleton(DioClient(getIt<Dio>()));
  //Signin
  getIt.registerSingleton(SignInApi(dioClient: getIt<DioClient>()));
  getIt.registerSingleton(SignInRepository(getIt.get<SignInApi>()));
  getIt.registerSingleton(SignInDataController());

  //Signup
  getIt.registerSingleton(SignupApi(dioClient: getIt<DioClient>()));
  getIt.registerSingleton(SignupRepository(getIt.get<SignupApi>()));
  getIt.registerSingleton(SignupDataController());

  //VerifyOTP
  getIt.registerSingleton(VerifyOtpApi(dioClient: getIt<DioClient>()));
  getIt.registerSingleton(VerifyOtpRepository(getIt.get<VerifyOtpApi>()));
  getIt.registerSingleton(VerifyOtpDataController());

  //Lead Details
  getIt.registerSingleton(ForgotPasswordApi(dioClient: getIt<DioClient>()));
  getIt.registerSingleton(ForgotPasswordRepository(getIt.get<ForgotPasswordApi>()));
  getIt.registerSingleton(ForgotPasswordController());

  //AddLead
  getIt.registerSingleton(AddLeadApi(dioClient: getIt<DioClient>()));
  getIt.registerSingleton(AddLeadRepository(getIt.get<AddLeadApi>()));
  getIt.registerSingleton(AddLeadDataController());

  //Home
  getIt.registerSingleton(HomeApi(dioClient: getIt<DioClient>()));
  getIt.registerSingleton(HomeRepository(getIt.get<HomeApi>()));
  getIt.registerSingleton(HomeDataController());

  //Export
  getIt.registerSingleton(ExportLeadApi(dioClient: getIt<DioClient>()));
  getIt.registerSingleton(ExportLeadRepository(getIt.get<ExportLeadApi>()));
  getIt.registerSingleton(ExportLeadDataController());

  //Change Password
  getIt.registerSingleton(ForgetPasswordApi(dioClient: getIt<DioClient>()));
  getIt.registerSingleton(ChangePasswordRepository(getIt.get<ForgetPasswordApi>()));
  getIt.registerSingleton(ChangePasswordController());

  //Update Company Profile
  getIt.registerSingleton(UpdateCompanyProfileApi(dioClient: getIt<DioClient>()));
  getIt.registerSingleton(UpdateCompanyProfileRepository(getIt.get<UpdateCompanyProfileApi>()));
  getIt.registerSingleton(UpdateCompanyProfileController());

  //Lead Details
  getIt.registerSingleton(LeadDetailsApi(dioClient: getIt<DioClient>()));
  getIt.registerSingleton(LeadDetailsRepository(getIt.get<LeadDetailsApi>()));
  getIt.registerSingleton(LeadDetailsController());

  //Notification
  getIt.registerSingleton(NotificationApi(dioClient: getIt<DioClient>()));
  getIt.registerSingleton(NotificationRepository(getIt.get<NotificationApi>()));
  getIt.registerSingleton(NotificationDataController());

  await initializeDateFormatting();
  // Firebase Setup
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: 'Inquiryapp',
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print('User granted permission');
  } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
    print('User granted provisional permission');
  } else {
    print('User declined or has not accepted permission');
  }


}

Future<bool> isLoggedIn() async {
  final user = await SharedPref.read("user");
  return user != null;
}
void setupAfterRunApp() async {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = AppColors.white
    ..backgroundColor = AppColors.primary
    ..indicatorColor = AppColors.white
    ..textColor = AppColors.white
    ..userInteractions = true
    ..dismissOnTap = false;
}