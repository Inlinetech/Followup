class NotificationBaseModel {
  bool? status;
  String? message;
  List<NotificationDataModel>? data;

  NotificationBaseModel({this.status, this.message, this.data});

  NotificationBaseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <NotificationDataModel>[];
      json['data'].forEach((v) {
        data!.add(NotificationDataModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NotificationDataModel {
  String? id;
  String? leadName;
  String? mobile;
  String? address;
  String? address1;
  String? pincode;
  String? city;
  String? customMessage;
  String? notes;
  String? message;

  NotificationDataModel(
      {this.id,
        this.leadName,
        this.mobile,
        this.address,
        this.address1,
        this.pincode,
        this.city,
        this.customMessage,
        this.notes,
        this.message});

  NotificationDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    leadName = json['lead_name'];
    mobile = json['mobile'];
    address = json['address'];
    address1 = json['address1'];
    pincode = json['pincode'];
    city = json['city'];
    customMessage = json['custom_message'];
    notes = json['notes'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['lead_name'] = leadName;
    data['mobile'] = mobile;
    data['address'] = address;
    data['address1'] = address1;
    data['pincode'] = pincode;
    data['city'] = city;
    data['custom_message'] = customMessage;
    data['notes'] = notes;
    data['message'] = message;
    return data;
  }

  get fullAddress => '${address ?? ''}, ${address1 ?? ''} ${city ?? ''}-${pincode ?? ''}';
}