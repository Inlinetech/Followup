import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:inquiryapp/common/app_image.dart';
import 'package:inquiryapp/common/app_routes.dart';
import 'package:inquiryapp/common/app_strings.dart';
import 'package:inquiryapp/common/app_textstyle.dart';
import 'package:inquiryapp/common/shared_pref_helper.dart';
import 'package:inquiryapp/common/utillity_helper.dart';
import 'package:inquiryapp/common/widgets/app_text_button.dart';
import 'package:inquiryapp/common/widgets/app_text_form_field.dart';
import 'package:inquiryapp/screens/signup/controller/signup_controller.dart';

import 'signin/controller/signin_controller.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {

  final SignInDataController signInDataController = Get.put(SignInDataController());
  final SignupDataController signupDataController = Get.put(SignupDataController());

  final TextEditingController mobileController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController companyNameController = TextEditingController();

  final TextEditingController businessCategoryController =
      TextEditingController();
  final TextEditingController businessTypeController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController cityController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      signupDataController.getBusinessCategories();
      signupDataController.getBusinessTypes();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Stack(
                  children: [
                    Image.asset(
                      AppImage.iconBackgroundEditProfile,
                      fit: BoxFit.fill,
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 15, right: 15, top: 25).r,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(top: 20).r,
                              child: SvgPicture.asset(
                                  AppImage.iconBackEditProfile),
                            ),
                          ),
                          // GestureDetector(
                          //   onTap: () {
                          //     Get.back();
                          //   },
                          //   child: Padding(
                          //     padding: const EdgeInsets.only(top: 20).r,
                          //     child: SvgPicture.asset(AppImage.iconEditRound),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ],
                ),
                Center(
                  child: SizedBox(
                    width: 1.sw,
                    height: 208.w,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SvgPicture.asset(AppImage.iconEditAvatar),
                        SizedBox(
                          height: 15.h,
                        ),
                        GetBuilder<SignInDataController>(
                          builder: (signInDataController) {
                            return Text(
                              signInDataController.user?.username ?? '',
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              style: AppTextStyle.instance.semiBoldBlack18,
                            );
                          }
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 20).r,
              child: GetBuilder<SignInDataController>(
                builder: (signInDataController) {
                  mobileController.text = signInDataController.user?.mobile ?? '';
                  emailController.text = signInDataController.user?.email ?? '';
                  passwordController.text = signInDataController.user?.mobile ?? '';
                  companyNameController.text = signInDataController.user?.companyName ?? '';
                  stateController.text = signInDataController.user?.state ?? '';
                  cityController.text = signInDataController.user?.city ?? '';
                  businessCategoryController.text = signInDataController.user?.businessCategoryId ?? '';
                  businessTypeController.text = signInDataController.user?.businessTypeId ?? '';
                  return Column(
                    children: [
                      Column(
                        children: [
                          AppTextFormField(
                            title: AppStrings.mobile,
                            hintText: AppStrings.enterMobile,
                            readOnly: true,
                            controller: mobileController,
                            keyboardType: TextInputType.phone,
                            maxLength: 10,
                            // suffixConstrain: const BoxConstraints(
                            //     maxHeight: 35.5, maxWidth: 32.5),
                            // suffixIcon: Padding(
                            //   padding: const EdgeInsets.only(right: 5, bottom: 5),
                            //   child: SvgPicture.asset(AppImage.iconEdit),
                            // ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          AppTextFormField(
                            title: AppStrings.emailAddress,
                            hintText: AppStrings.enterEmailAddress,
                            readOnly: true,
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            // suffixConstrain: const BoxConstraints(
                            //     maxHeight: 35.5, maxWidth: 32.5),
                            // suffixIcon: Padding(
                            //   padding: const EdgeInsets.only(right: 5, bottom: 5),
                            //   child: SvgPicture.asset(AppImage.iconEdit),
                            // ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          AppTextFormField(
                            title: AppStrings.password,
                            hintText: AppStrings.enterPassword,
                            readOnly: true,
                            controller: passwordController,
                            obscureText: true,
                            suffixConstrain: const BoxConstraints(
                                maxHeight: 35.5, maxWidth: 32.5),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                Get.toNamed(AppRoutes.changePassword);
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(right: 5, bottom: 5),
                                child: SvgPicture.asset(AppImage.iconEdit),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Other Details',
                            style: AppTextStyle.instance.lightBlack17,
                          ),
                          GestureDetector(onTap: () {
                            Get.toNamed(AppRoutes.updateCompanyProfile);
                          },child: SvgPicture.asset(AppImage.iconEdit))
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      AppTextFormField(
                        title: AppStrings.companyName,
                        hintText: AppStrings.enterCompanyName,
                        controller: companyNameController,
                        readOnly: true,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      GetBuilder<SignupDataController>(
                        builder: (signupDataController) {

                          if ((signInDataController.user?.businessCategoryId ?? '') != '') {
                            businessCategoryController.text = signupDataController.getBusinessCategoryById(signInDataController.user?.businessCategoryId ?? '')?.name ?? '';
                          }

                          if ((signInDataController.user?.businessTypeId ?? '') != '') {
                            businessTypeController.text = signupDataController.getBusinessCategoryById(signInDataController.user?.businessTypeId ?? '')?.name ?? '';
                          }


                          return Column(
                            children: [
                              AppTextFormField(
                                  title: AppStrings.businessCategory,
                                  hintText: AppStrings.selectBusinessCategory,
                                  readOnly: true,
                                  controller: businessCategoryController),
                              SizedBox(
                                height: 20.h,
                              ),
                              AppTextFormField(
                                  title: AppStrings.businessType,
                                  readOnly: true,
                                  hintText: AppStrings.selectBusinessType,
                                  controller: businessTypeController),
                              SizedBox(
                                height: 20.h,
                              ),
                            ],
                          );
                        }
                      ),


                      Row(
                        children: [
                          Expanded(
                            child: AppTextFormField(
                                title: AppStrings.state,
                                hintText: AppStrings.selectState,
                                readOnly: true,
                                controller: stateController),
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
                          Expanded(
                            child: AppTextFormField(
                                title: AppStrings.city,
                                hintText: AppStrings.enterCity,
                                readOnly: true,
                                controller: cityController),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: AppTextButton(
                              side: const BorderSide(color: Colors.black, width: 1),
                              backgroundColor: Colors.transparent,
                              titleStyle: AppTextStyle.instance.lightBlack16,
                              title: AppStrings.logout,
                              onPressed: () async {
                                Get.offAllNamed(AppRoutes.signin);
                                await SharedPref.save("user", null);
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                }
              ),
            )
          ],
        ),
      ),
    );
  }
}
