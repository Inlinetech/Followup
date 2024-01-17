class SigninDataModel {
  bool? status;
  String? message;
  UserDataModel? data;

  SigninDataModel({this.status, this.message, this.data});

  SigninDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? UserDataModel.fromJson(json['data']) : null;
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

class UserDataModel {
  String? username;
  String? email;
  String? mobile;
  String? token;
  String? companyName;
  String? businessCategoryId;
  String? businessTypeId;
  String? state;
  String? city;

  UserDataModel(
      {this.username,
        this.email,
        this.mobile,
        this.token,
        this.companyName,
        this.businessCategoryId,
        this.businessTypeId,
        this.state,
        this.city});

  UserDataModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    email = json['email'];
    mobile = json['mobile'];
    token = json['token'];
    companyName = json['company_name'];
    businessCategoryId = json['business_category_id'];
    businessTypeId = json['business_type_id'];
    state = json['state'];
    city = json['city'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['email'] = email;
    data['mobile'] = mobile;
    data['token'] = token;
    data['company_name'] = companyName;
    data['business_category_id'] = businessCategoryId;
    data['business_type_id'] = businessTypeId;
    data['state'] = state;
    data['city'] = city;
    return data;
  }
}