class CheckedItems {
  int? status;
  String? message;
  dynamic price;
  dynamic totalPrice;

  CheckedItems({this.status, this.message, this.price,this.totalPrice});

  CheckedItems.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    price = json['price']??0;
    totalPrice = (json['price'] ?? 0) + 10;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['price'] = this.price;
    return data;
  }
}
