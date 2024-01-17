import 'package:flutter/material.dart';
import 'package:flutter_initicon/flutter_initicon.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:inquiryapp/common/app_colors.dart';
import 'package:inquiryapp/common/app_image.dart';
import 'package:inquiryapp/common/app_routes.dart';
import 'package:inquiryapp/common/app_textstyle.dart';
import 'package:inquiryapp/common/shared_pref_helper.dart';
import 'package:inquiryapp/common/utillity_helper.dart';
import 'package:inquiryapp/screens/add_lead/controller/add_lead_controller.dart';
import 'package:inquiryapp/screens/home/controller/home_controller.dart';
import 'package:inquiryapp/screens/signin/model/signin_data_model.dart';
import 'package:inquiryapp/screens/widgets/all_filter_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:tab_container/tab_container.dart';

import '../signin/controller/signin_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  TabContainerController controller = TabContainerController(length: 3);
  final SignInDataController signInDataController = Get.put(SignInDataController());
  final HomeDataController homeDataController = Get.put(HomeDataController());
  final AddLeadDataController addLeadDataController = Get.put(AddLeadDataController());
  bool isLoading = false;

  bool isChecked = false;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userDefaultToModel();
  }


  userDefaultToModel() async {
    try {
      if (SharedPref.read("user") != null) {
        final userDataModel = UserDataModel.fromJson(await SharedPref.read("user"));
        signInDataController.setUserDataModel(userDataModel);

        print("Token: ${signInDataController.user?.token}");

        WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
          await homeDataController.getLeads();
          await addLeadDataController.getLeadCategories();
        });
      }
    } catch (Excepetion) {
      print(Excepetion);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 20, top: 16).r,
          child: Column(
            children: [
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GetBuilder<SignInDataController>(
                        builder: (signInDataController) {
                          return GestureDetector(
                            onTap: () {
                              Get.toNamed(AppRoutes.editProfile);
                            },
                            child: Row(
                              children: [
                                Initicon(
                                  text: signInDataController.user?.username ?? '',
                                  backgroundColor: AppColors.primary,
                                  color: AppColors.white,
                                  size: 35.w,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      signInDataController.user?.username ?? '',
                                      style: AppTextStyle.instance.semiBoldBlack18,
                                    ),
                                    Text(
                                      'Welcome back',
                                      style: AppTextStyle.instance.lightGrey14,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          );
                        }
                      ),
                      GestureDetector(onTap: () {
                        Get.toNamed(AppRoutes.notification);
                      },child: SvgPicture.asset(AppImage.iconNotification))
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 36.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Your Lead's",
                    style: AppTextStyle.instance.semiBoldBlack18,
                  ),
                  GetBuilder<HomeDataController>(
                    builder: (homeController) {
                      return Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(15),
                                          topRight: Radius.circular(15))),
                                  context: context,
                                  builder: (context) {
                                    return AllFilterWidget(controller: controller, callback: (value) {
                                      setState(() {
                                        isFilterApplied = value;
                                      });
                                    });

                                  });
                            },
                            child: Container(
                              width: 74.w,
                              height: 29.h,
                              padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 8)
                                  .r,
                              decoration: BoxDecoration(
                                  color: isFilterApplied ? AppColors.primary : Colors.white,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(AppImage.iconSettings,colorFilter: ColorFilter.mode(isFilterApplied ? AppColors.white : AppColors.black, BlendMode.srcIn),),
                                  Text(
                                    "All",
                                    style: isFilterApplied ? AppTextStyle.instance.semiBoldWhite12 : AppTextStyle.instance.semiBoldBlack12,
                                  ),
                                  SvgPicture.asset(AppImage.iconDropDownArrow,colorFilter: ColorFilter.mode(isFilterApplied ? AppColors.white : AppColors.black, BlendMode.srcIn),),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.toNamed(AppRoutes.exportLeads);
                            },
                            child: Container(
                              width: 74.w,
                              height: 29.h,
                              padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 8)
                                  .r,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Text(
                                      "Export",
                                      style: AppTextStyle.instance.semiBoldBlack12,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 4.w,
                                  ),
                                  SvgPicture.asset(AppImage.iconExport),
                                ],
                              ),
                            ),
                          )
                        ],
                      );
                    }
                  )
                ],
              ),
              SizedBox(
                height: 8.h,
              ),
              GetBuilder<HomeDataController>(
                builder: (homeController) {
                  return Expanded(
                    child: homeController.leads.isNotEmpty ? ListView.builder(
                      physics: const ClampingScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final lead = homeController.leads[index];

                        return GestureDetector(
                          onTap: () {
                            Get.toNamed(AppRoutes.leadDetails,arguments: [lead]);
                          },
                          child: Container(
                            width: 1.sw,
                            padding: const EdgeInsets.all(10).r,
                            margin: const EdgeInsets.symmetric(vertical: 8).r,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8)),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          lead.leadName ?? '',
                                          style:
                                              AppTextStyle.instance.semiBoldBlack16,
                                        ),
                                        if ((lead.isFroud ?? '0') != '0')
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8, vertical: 3),
                                            margin: const EdgeInsets.only(left: 6),
                                            decoration: BoxDecoration(
                                                color: AppColors.darkRed,
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            child: Text(
                                              'Froud',
                                              style: AppTextStyle
                                                  .instance.regularWhite12,
                                            ),
                                          )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 7.h,
                                    ),
                                    Text(
                                      lead.mobile ?? '',
                                      style: AppTextStyle.instance.lightGrey14,
                                    ),
                                    if ((lead.notes ?? '').isNotEmpty)
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                    if ((lead.notes ?? '').isNotEmpty)
                                      Container(
                                          padding: const EdgeInsets.all(8).r,
                                          decoration: BoxDecoration(
                                              color: AppColors.lightGreenOpacity,
                                              borderRadius: BorderRadius.circular(6)),
                                          child: Text(
                                            'Notes: ${lead.notes}',
                                            style:
                                                AppTextStyle.instance.regularGreen12,
                                          ))
                                  ],
                                ),
                                GestureDetector(onTap: () {
                                  final mobile = lead.mobile;
                                  if (mobile != null && mobile.isNotEmpty) {
                                    UtilityHelper.instance.makePhoneCall(mobile);
                                  }
                                },child: SvgPicture.asset(AppImage.iconCall))
                              ],
                            ),
                          ),
                        );
                      },
                      itemCount: homeController.leads.length,
                    ) : Center(child: Text('No Data Found',style: AppTextStyle.instance.semiBoldGrey20,),),
                  );
                }
              ),
              GestureDetector(
                  onTap: () {
                    Get.toNamed(AppRoutes.addLead);
                  },
                  child: Lottie.asset(
                    AppImage.iconBtnAnimation,
                  )),
              SizedBox(
                height: 16.h,
              ),
            ],
          ),
        ),
      ),
    );
  }

  _clearFilter() {

  }



}

