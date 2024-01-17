class APIEndPoints {
  // baseURL
  static const baseUrl = "https://www.followuplead.com/api/";
  // receiveTimeout
  static const Duration receiveTimeout = Duration(seconds: 15);
  // connectTimeout
  static const Duration connectionTimeout = Duration(seconds: 15);

  //Signup APIs
  static const register = "register";
  static const businessCategory = "common/businesscategory";

  //VerifyOTP APIs
  static const otpVerification = "otp";

  //ForgotPassword
  static const forgotPassword = "forgotpassword";
  static const resetPassword = "resetpassword";

  //Signin APIs
  static const login = "login";

  //Home
  static const getLeads = "leads?";

  //Add Leads
  static const addLead = "lead/add";
  static const leadCategory = "common/leadclasstype";

  //Lead Details
  static const leadDetails = "lead/delete";
  static const leadFraud = "lead/froud";
  static const leadReminderStatus = 'lead/reminder';

  //Export Leads
  static const exportLeads = "lead/export";

  //Edit Profile
  static const businessTypes = "common/businesstypes";

  //Change Password
  static const changePassword = "/changepassword";

  //Update CompanyProfile
  static const updateProfile = "/updateprofile";

  //Notification
  static const notification = "notifications";
}