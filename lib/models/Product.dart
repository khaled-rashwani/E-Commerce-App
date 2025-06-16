
class ProductModel {
  Product? product;

  ProductModel({this.product});

  ProductModel.fromJson(Map<String, dynamic> json) {
    product =
    json['product'] != null ? new Product.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    return data;
  }
}

class Product {
  int? id;
  int? adminId;
  int? categoryId;
  String? name;
  int? price;
  String? description;
  int? discountPercentage;
  dynamic discountPrice;
  int? approved;
  int? productQuantity;
  String? createdAt;
  String? updatedAt;
  List<ProductImages>? productImages;
  List<ProductTags>? productTags;
  List<ProductVariants>? productVariants;

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
        this.createdAt,
        this.updatedAt,
        this.productImages,
        this.productTags,
        this.productVariants});


  Product.fromJson(Map<String, dynamic> json) {
    discountPrice=json['price']-(json['price']*json['discount_percentage']/100);
    id = json['id'];
    adminId = json['admin_id'];
    categoryId = json['category_id'];
    name = json['name'];
    price = json['price'];
    description = json['description'];
    discountPercentage = json['discount_percentage'];
    approved = json['approved'];
    productQuantity = json['product_quantity'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['product_images'] != null) {
      productImages = <ProductImages>[];
      json['product_images'].forEach((v) {
        productImages!.add(new ProductImages.fromJson(v));
      });
    }
    if (json['product_tags'] != null) {
      productTags = <ProductTags>[];
      json['product_tags'].forEach((v) {
        productTags!.add(new ProductTags.fromJson(v));
      });
    }
    if (json['product_variants'] != null) {
      productVariants = <ProductVariants>[];
      json['product_variants'].forEach((v) {
        productVariants!.add(new ProductVariants.fromJson(v));
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
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.productImages != null) {
      data['product_images'] =
          this.productImages!.map((v) => v.toJson()).toList();
    }
    if (this.productTags != null) {
      data['product_tags'] = this.productTags!.map((v) => v.toJson()).toList();
    }
    if (this.productVariants != null) {
      data['product_variants'] =
          this.productVariants!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductImages {
  int? id;
  int? productId;
  String? productImage;
  Null? createdAt;
  Null? updatedAt;

  ProductImages(
      {this.id,
        this.productId,
        this.productImage,
        this.createdAt,
        this.updatedAt});

  ProductImages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    productImage = json['product_image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_id'] = this.productId;
    data['product_image'] = this.productImage;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class ProductTags {
  int? productId;
  int? tagId;
  Tag? tag;

  ProductTags({this.productId, this.tagId, this.tag});

  ProductTags.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    tagId = json['tag_id'];
    tag = json['tag'] != null ? new Tag.fromJson(json['tag']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['tag_id'] = this.tagId;
    if (this.tag != null) {
      data['tag'] = this.tag!.toJson();
    }
    return data;
  }
}

class Tag {
  int? id;
  String? tag;

  Tag({this.id, this.tag});

  Tag.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tag = json['tag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['tag'] = this.tag;
    return data;
  }
}

class ProductVariants {
  int? id;
  int? productId;
  int? colorId;
  int? sizeId;
  int? variantQuantity;
  Size? size;
  Color? color;

  ProductVariants(
      {this.id,
        this.productId,
        this.colorId,
        this.sizeId,
        this.variantQuantity,
        this.size,
        this.color});

  ProductVariants.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    colorId = json['color_id'];
    sizeId = json['size_id'];
    variantQuantity = json['variant_quantity'];
    size = json['size'] != null ? new Size.fromJson(json['size']) : null;
    color = json['color'] != null ? new Color.fromJson(json['color']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_id'] = this.productId;
    data['color_id'] = this.colorId;
    data['size_id'] = this.sizeId;
    data['variant_quantity'] = this.variantQuantity;
    if (this.size != null) {
      data['size'] = this.size!.toJson();
    }
    if (this.color != null) {
      data['color'] = this.color!.toJson();
    }
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
