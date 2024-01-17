import 'package:dio/dio.dart';
import 'package:inquiryapp/common/network/dio_exceptions.dart';
import 'package:inquiryapp/screens/notification/api/notification_screen_api.dart';
import 'package:inquiryapp/screens/notification/model/notification_screen_model.dart';

class NotificationRepository {
  final NotificationApi notificationApi;

  NotificationRepository(this.notificationApi);

  Future<NotificationBaseModel> getNotificationApi() async {
    try {
      final response = await notificationApi.getNotificationApi();
      return NotificationBaseModel.fromJson(response.data);
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }
}