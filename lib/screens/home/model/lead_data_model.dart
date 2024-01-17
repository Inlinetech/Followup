class LeadBaseModel {
  String? message;
  List<LeadDataModel>? data;

  LeadBaseModel({this.message, this.data});

  LeadBaseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <LeadDataModel>[];
      json['data'].forEach((v) {
        data!.add(LeadDataModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LeadDataModel {
  String? id;
  String? customersClassTypeId;
  String? leadName;
  String? mobile;
  String? address;
  String? address1;
  String? pincode;
  String? city;
  String? landmark;
  String? shopName;
  String? customMessage;
  String? notes;
  String? reminderType;
  String? specificDate;
  String? reminderStatus;
  String? isFroud;
  bool? isSelected;

  LeadDataModel(
      {this.id,
        this.customersClassTypeId,
        this.leadName,
        this.mobile,
        this.address,
        this.address1,
        this.pincode,
        this.city,
        this.landmark,
        this.shopName,
        this.customMessage,
        this.notes,
        this.reminderType,
        this.specificDate,
        this.reminderStatus,
        this.isFroud,this.isSelected = false});

  LeadDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customersClassTypeId = json['customers_class_type_id'];
    leadName = json['lead_name'];
    mobile = json['mobile'];
    address = json['address'];
    address1 = json['address1'];
    pincode = json['pincode'];
    city = json['city'];
    landmark = json['landmark'];
    shopName = json['shop_name'];
    customMessage = json['custom_message'];
    notes = json['notes'];
    reminderType = json['reminder_type'];
    specificDate = json['specific_date'];
    reminderStatus = json['reminder_status'];
    isFroud = json['is_froud'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['customers_class_type_id'] = customersClassTypeId;
    data['lead_name'] = leadName;
    data['mobile'] = mobile;
    data['address'] = address;
    data['address1'] = address1;
    data['pincode'] = pincode;
    data['city'] = city;
    data['landmark'] = landmark;
    data['shop_name'] = shopName;
    data['custom_message'] = customMessage;
    data['notes'] = notes;
    data['reminder_type'] = reminderType;
    data['specific_date'] = specificDate;
    data['reminder_status'] = reminderStatus;
    data['is_froud'] = isFroud;
    return data;
  }

  String get fullAddress {
    return (address ?? '') + (', ') + (address1 ?? '') + (', ') + (city ?? '') + ('-') + (pincode ?? '');
  }
}