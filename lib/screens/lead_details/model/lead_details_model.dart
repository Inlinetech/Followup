import 'package:inquiryapp/screens/home/model/lead_data_model.dart';

class ReminderStatusDataModel {
  bool? status;
  String? message;
  LeadDataModel? data;

  ReminderStatusDataModel({this.status, this.message, this.data});

  ReminderStatusDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? LeadDataModel.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}