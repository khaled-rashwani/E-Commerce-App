class StoresModel {
  List<Data>? data;

  StoresModel({this.data});

  StoresModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? companyName;
  String? email;
  String? logo;
  String? description;
  String? phoneNumber;
  dynamic wallet;
  dynamic percentage;
  int? state;
  Null? createdAt;
  Null? updatedAt;

  Data(
      {this.id,
        this.companyName,
        this.email,
        this.logo,
        this.description,
        this.phoneNumber,
        this.wallet,
        this.percentage,
        this.state,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyName = json['company_name'];
    email = json['email'];
    logo = json['logo'];
    description = json['description'];
    phoneNumber = json['phone_number'];
    wallet = json['wallet'];
    percentage = json['percentage'];
    state = json['state'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['company_name'] = this.companyName;
    data['email'] = this.email;
    data['logo'] = this.logo;
    data['description'] = this.description;
    data['phone_number'] = this.phoneNumber;
    data['wallet'] = this.wallet;
    data['percentage'] = this.percentage;
    data['state'] = this.state;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
