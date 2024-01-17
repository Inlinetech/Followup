import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:inquiryapp/common/app_image.dart';
import 'package:inquiryapp/common/app_textstyle.dart';
import 'package:inquiryapp/common/utillity_helper.dart';
import 'package:inquiryapp/screens/notification/controller/notification_screen_controller.dart';

import '../../common/app_colors.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final NotificationDataController notificationDataController = Get.put(NotificationDataController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notificationDataController.getNotifications();
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
                          "Notification",
                          style: AppTextStyle.instance.semiBoldBlack20,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),

                ],
              ),
              GetBuilder<NotificationDataController>(
                  builder: (notificationDataController) {

                    return Expanded(
                      child: notificationDataController.notifications.isNotEmpty ? ListView.builder(
                        physics: const ClampingScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final notification = notificationDataController.notifications[index];

                          return GestureDetector(
                            onTap: () {

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
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              ((notification.leadName ?? '') != '' ? '${notification.leadName ?? ''} ' : '').capitalize!,
                                              style:
                                              AppTextStyle.instance.semiBoldBlue16,
                                            ),
                                            Text(
                                              (notification.message ?? '').toLowerCase(),
                                              style:
                                              AppTextStyle.instance.lightBlack16,
                                            ),

                                          ],
                                        ),
                                        SizedBox(
                                          height: 7.h,
                                        ),
                                        Text(
                                          notification.mobile ?? '',
                                          style: AppTextStyle.instance.lightGrey14,
                                        ),
                                        SizedBox(
                                          height: 7.h,
                                        ),
                                        Text(
                                          notification.fullAddress ?? '',
                                          style: AppTextStyle.instance.lightGrey14,
                                        ),
                                        if ((notification.notes ?? '').isNotEmpty)
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                        if ((notification.notes ?? '').isNotEmpty)
                                          Container(
                                              padding: const EdgeInsets.all(8).r,
                                              decoration: BoxDecoration(
                                                  color: AppColors.lightGreenOpacity,
                                                  borderRadius: BorderRadius.circular(6)),
                                              child: Text(
                                                'Notes: ${notification.notes}',
                                                style:
                                                AppTextStyle.instance.regularGreen12,
                                              ))
                                      ],
                                    ),
                                  ),
                                  GestureDetector(onTap: () {
                                    final mobile = notification.mobile;
                                    if (mobile != null && mobile.isNotEmpty) {
                                      UtilityHelper.instance.makePhoneCall(mobile);
                                    }
                                  },child: SvgPicture.asset(AppImage.iconCall))
                                ],
                              ),
                            ),
                          );
                        },
                        itemCount: notificationDataController.notifications.length,
                      ) : Center(child: Text('No Data Found',style: AppTextStyle.instance.semiBoldGrey20,),),
                    );
                  }
              ),

            ],
          ),
        ),
      ),
    );
  }

}
