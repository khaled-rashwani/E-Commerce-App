class CartModel {
  int? status;
  List<CartItems>? cartItems;

  CartModel({this.status, this.cartItems});

  CartModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['cart_items'] != null) {
      cartItems = <CartItems>[];
      json['cart_items'].forEach((v) {
        cartItems!.add(new CartItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.cartItems != null) {
      data['cart_items'] = this.cartItems!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CartItems {
  int? variantId;
  Product? product;
  Size? size;
  Color? color;
  int? quantity;

  CartItems(
      {this.variantId, this.product, this.size, this.color, this.quantity});

  CartItems.fromJson(Map<String, dynamic> json) {
    variantId = json['variant_id'];
    product =
    json['product'] != null ? new Product.fromJson(json['product']) : null;
    size = json['size'] != null ? new Size.fromJson(json['size']) : null;
    color = json['color'] != null ? new Color.fromJson(json['color']) : null;
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['variant_id'] = this.variantId;
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    if (this.size != null) {
      data['size'] = this.size!.toJson();
    }
    if (this.color != null) {
      data['color'] = this.color!.toJson();
    }
    data['quantity'] = this.quantity;
    return data;
  }
}

class Product {
  int? id;
  int? adminId;
  int? categoryId;
  String? name;
  int? price;
  dynamic discountPrice;
  dynamic totalProductsPrice;
  String? description;
  int? discountPercentage;
  int? approved;
  int? productQuantity;
  List<ProductImages>? productImages;

  Product(
      {this.id,
        this.adminId,
        this.categoryId,
        this.name,
        this.price,
        this.description,
        this.discountPercentage,
        this.approved,
        this.productQuantity,
        this.productImages});

  Product.fromJson(Map<String, dynamic> json) {
    discountPrice=json['price']-(json['price']*json['discount_percentage']/100);
    totalProductsPrice=(json['price']-(json['price']*json['discount_percentage']/100));
    id = json['id'];
    adminId = json['admin_id'];
    categoryId = json['category_id'];
    name = json['name'];
    price = json['price'];
    description = json['description'];
    discountPercentage = json['discount_percentage'];
    approved = json['approved'];
    productQuantity = json['product_quantity'];
    if (json['product_images'] != null) {
      productImages = <ProductImages>[];
      json['product_images'].forEach((v) {
        productImages!.add(new ProductImages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['admin_id'] = this.adminId;
    data['category_id'] = this.categoryId;
    data['name'] = this.name;
    data['price'] = this.price;
    data['description'] = this.description;
    data['discount_percentage'] = this.discountPercentage;
    data['approved'] = this.approved;
    data['product_quantity'] = this.productQuantity;
    if (this.productImages != null) {
      data['product_images'] =
          this.productImages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductImages {
  int? id;
  int? productId;
  String? productImage;

  ProductImages({this.id, this.productId, this.productImage});

  ProductImages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    productImage = json['product_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_id'] = this.productId;
    data['product_image'] = this.productImage;
    return data;
  }
}

class Size {
  int? id;
  String? size;
  int? typeId;

  Size({this.id, this.size, this.typeId});

  Size.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    size = json['size'];
    typeId = json['type_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['size'] = this.size;
    data['type_id'] = this.typeId;
    return data;
  }
}

class Color {
  int? id;
  String? color;
  String? hex;

  Color({this.id, this.color, this.hex});

  Color.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    color = json['color'];
    hex = json['hex'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['color'] = this.color;
    data['hex'] = this.hex;
    return data;
  }
}
