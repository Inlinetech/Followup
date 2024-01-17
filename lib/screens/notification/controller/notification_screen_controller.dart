import 'package:get/get.dart';
import 'package:inquiryapp/common/singleton_services.dart';
import 'package:inquiryapp/common/utillity_helper.dart';
import 'package:inquiryapp/screens/notification/api/notification_screen_repository.dart';
import 'package:inquiryapp/screens/notification/model/notification_screen_model.dart';

class NotificationDataController extends GetxController {
  final notificationRepo = getIt.get<NotificationRepository>();

  //Leads
  List<NotificationDataModel> get notifications => _notifications;

  List<NotificationDataModel> _notifications = [];

  setNotifications(List<NotificationDataModel> value) {
    _notifications = value;
    update();
  }


  Future<NotificationBaseModel> getNotifications() async {
    UtilityHelper.instance.showLoader();
    final notificationData = await notificationRepo.getNotificationApi();
    setNotifications(notificationData.data ?? []);
    UtilityHelper.instance.hideLoader();
    return notificationData;
  }

}
