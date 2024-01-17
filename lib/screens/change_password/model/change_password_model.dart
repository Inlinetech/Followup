class ChangePasswordDataModel {
  bool? status;
  String? message;
  dynamic data;

  ChangePasswordDataModel({this.status, this.message,this.data});

  ChangePasswordDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dataObj = <String, dynamic>{};
    dataObj['status'] = status;
    dataObj['message'] = message;
    dataObj['data']= data;
    return dataObj;
  }
}