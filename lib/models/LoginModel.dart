class LoginModel {
  int? status;
  String? message;
  Data? data;
  String? token;

  LoginModel({this.status, this.message, this.data, this.token});

  LoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['token'] = this.token;
    return data;
  }
}

class Data {
  int? id;
  String? userName;
  String? email;
  Null? emailVerifiedAt;
  String? address;
  String? phoneNumber;
  String? profileImgUrl;
  int? wallet;

  Data(
      {this.id,
        this.userName,
        this.email,
        this.emailVerifiedAt,
        this.address,
        this.phoneNumber,
        this.profileImgUrl,
        this.wallet});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['user_name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    address = json['address'];
    phoneNumber = json['phone_number'];
    profileImgUrl = json['profile_img_url'];
    wallet = json['wallet'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_name'] = this.userName;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['address'] = this.address;
    data['phone_number'] = this.phoneNumber;
    data['profile_img_url'] = this.profileImgUrl;
    data['wallet'] = this.wallet;
    return data;
  }
}