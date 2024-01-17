import 'package:get/get.dart';
import 'package:inquiryapp/screens/add_lead/add_lead_screen.dart';
import 'package:inquiryapp/screens/change_password/change_password_screen.dart';
import 'package:inquiryapp/screens/complete_profile/complete_profile_screen.dart';
import 'package:inquiryapp/screens/edit_profile_screen.dart';
import 'package:inquiryapp/screens/export/export_lead_screen.dart';
import 'package:inquiryapp/screens/forgot_password/forgot_password_screen.dart';
import 'package:inquiryapp/screens/home/home_screen.dart';
import 'package:inquiryapp/screens/lead_details/lead_detail_screen.dart';
import 'package:inquiryapp/screens/notification/notification_screen.dart';
import 'package:inquiryapp/screens/reset_password.dart';
import 'package:inquiryapp/screens/set_reminder_screen.dart';
import 'package:inquiryapp/screens/signin/signin_screen.dart';
import 'package:inquiryapp/screens/signup/signup_screen.dart';
import 'package:inquiryapp/screens/success_screen.dart';
import 'package:inquiryapp/screens/update_company_profile/update_company_profile_screen.dart';
import 'package:inquiryapp/screens/verifyotp/verify_otp_screen.dart';

class AppRoutes {
  static String signin = '/signin';
  static String signup = '/signup';
  static String verifyOtp = '/verifyotp';
  static String resetPassword = '/resetpassword';
  static String forgotPassword = '/forgotpassword';
  static String successScreen = '/successmessage';
  static String completeProfile = '/completeprofile';
  static String home = '/homeScreen';
  static String notification = '/notification';
  static String addLead = '/addlead';
  static String leadDetails = '/leadDetails';
  static String setReminder = '/setReminder';
  static String exportLeads = '/exportLeads';
  static String editProfile = '/editProfile';
  static String changePassword = '/changePassword';
  static String updateCompanyProfile = '/updateCompanyProfile';
}

final getPages = [
  GetPage(name: AppRoutes.signin, page: () => const SigninScreen(),),
  GetPage(name: AppRoutes.signup, page: () => const SignupScreen()),
  GetPage(name: AppRoutes.verifyOtp, page: () => VerifyOTPScreen(mobile: Get.arguments[0],fromScreen: Get.arguments[1],)),
  GetPage(name: AppRoutes.forgotPassword, page: () => const ForgotPasswordScreen()),
  GetPage(name: AppRoutes.resetPassword, page: () => ResetPasswordScreen(mobile: Get.arguments[0],)),
  GetPage(name: AppRoutes.completeProfile, page: () => const CompleteProfileScreen()),
  GetPage(name: AppRoutes.home, page: () => const HomeScreen()),
  GetPage(name: AppRoutes.notification, page: () => const NotificationScreen()),
  GetPage(name: AppRoutes.addLead, page: () => const AddLeadScreen()),
  GetPage(name: AppRoutes.leadDetails, page: () => LeadDetailsScreen(leadDataModel: Get.arguments[0],)),
  GetPage(name: AppRoutes.setReminder, page: () => const SetReminderScreen()),
  GetPage(name: AppRoutes.exportLeads, page: () => const ExportLeadScreen()),
  GetPage(name: AppRoutes.editProfile, page: () => const EditProfileScreen()),
  GetPage(name: AppRoutes.changePassword, page: () => const ChangePasswordScreen()),
  GetPage(name: AppRoutes.updateCompanyProfile, page: () => const UpdateCompanyProfileScreen()),
  GetPage(name: AppRoutes.successScreen, page: () =>  SuccessWithMessageScreen(title: Get.arguments[0],description: Get.arguments[1],isCompleteProfile: Get.arguments[2],backgroundColor: Get.arguments[3],isWhiteText: Get.arguments[4],successType: Get.arguments[5],isRemoveAnimation: Get.arguments[6],)),

];