class RegisterModel {
  int? status;
  String? message;
  Data? data;
  String? accessToken;

  RegisterModel({this.status, this.message, this.data, this.accessToken});

  RegisterModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    accessToken = json['accessToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['accessToken'] = this.accessToken;
    return data;
  }
}

class Data {
  String? userName;
  String? email;
  String? phoneNumber;
  String? address;
  int? id;

  Data({this.userName, this.email, this.phoneNumber, this.address, this.id});

  Data.fromJson(Map<String, dynamic> json) {
    userName = json['user_name'];
    email = json['email'];
    phoneNumber = json['phone_number'];
    address = json['address'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_name'] = this.userName;
    data['email'] = this.email;
    data['phone_number'] = this.phoneNumber;
    data['address'] = this.address;
    data['id'] = this.id;
    return data;
  }
}