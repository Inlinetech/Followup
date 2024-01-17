import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:inquiryapp/common/app_image.dart';
import 'package:inquiryapp/common/app_strings.dart';
import 'package:inquiryapp/common/app_textstyle.dart';
import 'package:inquiryapp/common/utillity_helper.dart';
import 'package:inquiryapp/common/widgets/app_text_button.dart';
import 'package:inquiryapp/screens/export/controller/export_lead_controller.dart';
import 'package:inquiryapp/screens/home/controller/home_controller.dart';
import 'package:inquiryapp/screens/home/home_screen.dart';
import 'package:inquiryapp/screens/widgets/all_filter_widget.dart';
import 'package:tab_container/tab_container.dart';

import '../../common/app_colors.dart';

class ExportLeadScreen extends StatefulWidget {
  const ExportLeadScreen({super.key});

  @override
  State<ExportLeadScreen> createState() => _ExportLeadScreenState();
}

class _ExportLeadScreenState extends State<ExportLeadScreen> {
  final HomeDataController homeDataController = Get.put(HomeDataController());
  final ExportLeadDataController exportLeadDataController = Get.put(ExportLeadDataController());

  TabContainerController controller = TabContainerController(length: 3);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      if (!isFilterApplied) {
        await homeDataController.getLeads();
        exportLeadDataController.setLeads(homeDataController.leads);
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15).r,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 20).r,
                  child: SvgPicture.asset(AppImage.iconBackLightBorder),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Export Leads",
                          style: AppTextStyle.instance.semiBoldBlack20,
                        ),
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
                        GetBuilder<ExportLeadDataController>(
                          builder: (exportLeadDataController) {
                            return GestureDetector(
                              onTap: () {
                                if (exportLeadDataController.isAllSelected) {
                                  exportLeadDataController.setClearAllLeads();
                                } else {
                                  exportLeadDataController.setSelectedAllLeads();
                                }

                              },
                              child: Row(children: [
                                Text(
                                  "Select All",
                                  style: AppTextStyle.instance.regularBlack16,
                                ),
                                const SizedBox(width: 8,),
                                SvgPicture.asset(exportLeadDataController.isAllSelected ? AppImage.iconChecked :AppImage.iconUnChecked)
                              ],),
                            );
                          }
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                ],
              ),
              GetBuilder<ExportLeadDataController>(
                builder: (exportLeadDataController) {
                  return Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final lead = exportLeadDataController.leads[index];
                        return Container(
                          margin: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8)),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: ListTile(
                              onTap: () {
                                exportLeadDataController.setSelectedLeads(lead);
                              },
                              shape: RoundedRectangleBorder( //<-- SEE HERE
                                side: const BorderSide(width: 1,color: Color(0xffF4F4F4)),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              title: Text(
                                lead.leadName ?? '',
                                style: AppTextStyle.instance.semiBoldBlack14,
                              ),
                              subtitle: Text(lead.mobile ?? '',
                                  style: AppTextStyle.instance.lightGrey12),
                              trailing: SvgPicture.asset(lead.isSelected ?? false ? AppImage.iconChecked : AppImage.iconUnChecked),
                            ),
                          ),
                        );
                      },
                      itemCount: exportLeadDataController.leads.length,
                    ),
                  );
                }
              ),
              Column(
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  GetBuilder<ExportLeadDataController>(
                    builder: (exportLeadDataController) {
                      return Row(
                        children: [
                          if (exportLeadDataController.selectedLeads.isNotEmpty) Expanded(
                            child: AppTextButton(
                              backgroundColor: Colors.transparent,
                              title: AppStrings.clear,
                              titleStyle: AppTextStyle.instance.lightGrey16,
                              onPressed: () {
                                exportLeadDataController.setClearAllLeads();
                              },
                            ),
                          ),
                          if (exportLeadDataController.selectedLeads.isNotEmpty) SizedBox(
                            width: 20.w,
                          ),
                          Expanded(
                            child: AppTextButton(
                              title: AppStrings.export,
                              onPressed: () async {
                                if (exportLeadDataController.selectedLeads.isNotEmpty) {
                                  final responseModel = await exportLeadDataController.exportLeads();
                                  if (GetUtils.isURL(responseModel.data ?? '')) {
                                    Get.back();
                                    UtilityHelper.instance.showSuccess(AppStrings.successful, responseModel.message ?? '');
                                    Future.delayed(const Duration(seconds: 2), () {
                                      UtilityHelper.instance.launchInBrowser(responseModel.data ?? '');
                                    });
                                  }
                                } else {
                                  UtilityHelper.instance
                                      .showError(AppStrings.error, "Please select lead");
                                }

                              },
                            ),
                          ),
                        ],
                      );
                    }
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

}
