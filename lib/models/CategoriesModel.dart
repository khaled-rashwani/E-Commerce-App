class CategoriesModel {
  int? status;
  List<Data>? data;

  CategoriesModel({this.status, this.data});

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['status'] = this.status;
  //   if (this.data != null) {
  //     data['data'] = this.data!.map((v) => v.toJson()).toList();
  //   }
  //   return data;
  // }
}

class Data {
  int? id;
  String? name;
  String? image;
  int? iLft;
  int? iRgt;
  int? parentId;
  String? createdAt;
  String? updatedAt;
  List<Products>? products;
  List<Children>? children;

  Data(
      {this.id,
        this.name,
        this.image,
        this.iLft,
        this.iRgt,
        this.parentId,
        this.createdAt,
        this.updatedAt,
        this.products,
        this.children});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    iLft = json['_lft'];
    iRgt = json['_rgt'];
    parentId = json['parent_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['children'] != null) {
      children = <Children>[];
      json['children'].forEach((v) {
        children!.add(new Children.fromJson(v));
      });
    }
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['_lft'] = this.iLft;
    data['_rgt'] = this.iRgt;
    data['parent_id'] = this.parentId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;

    if (this.children != null) {
      data['children'] = this.children!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Children {
  int? id;
  String? name;
  String? image;
  int? iLft;
  int? iRgt;
  int? parentId;
  String? createdAt;
  String? updatedAt;
  List<Products>? products;
  List<Children>? children;

  Children(
      {this.id,
        this.name,
        this.image,
        this.iLft,
        this.iRgt,
        this.parentId,
        this.createdAt,
        this.updatedAt,
        this.products,
        this.children});

  Children.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    iLft = json['_lft'];
    iRgt = json['_rgt'];
    parentId = json['parent_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }

    // if (json['children'] != null) {
    //   children = <Children>[];
    //   json['children'].forEach((v) {
    //     children!.add(new Children.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['_lft'] = this.iLft;
    data['_rgt'] = this.iRgt;
    data['parent_id'] = this.parentId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    if (this.children != null) {
      data['children'] = this.children!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Products {
  int? id;
  int? adminId;
  int? categoryId;
  String? name;
  dynamic price;
  String? description;
  dynamic discountPercentage;
  dynamic discountPrice;
  dynamic approved;
  dynamic productQuantity;
  String? createdAt;
  String? updatedAt;
  Admin? admin;
  List<ProductImages>? productImages;
  List<ProductTags>? productTags;
  List<ProductVariants>? productVariants;

  Products(
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
        this.admin,
        this.productImages,
        this.productTags,
        this.productVariants});

  Products.fromJson(Map<String, dynamic> json) {
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
    admin = json['admin'] != null ? new Admin.fromJson(json['admin']) : null;
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
    if (this.admin != null) {
      data['admin'] = this.admin!.toJson();
    }
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

class ProductTags {
  int? productId;
  int? tagId;
  Null? createdAt;
  Null? updatedAt;

  ProductTags({this.productId, this.tagId, this.createdAt, this.updatedAt});

  ProductTags.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    tagId = json['tag_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['tag_id'] = this.tagId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Admin {
  int? id;
  String? companyName;
  String? email;
  String? logo;
  String? description;
  String? phoneNumber;
  dynamic wallet;
  int? state;
  String? createdAt;
  String? updatedAt;

  Admin(
      {this.id,
        this.companyName,
        this.email,
        this.logo,
        this.description,
        this.phoneNumber,
        this.wallet,
        this.state,
        this.createdAt,
        this.updatedAt});

  Admin.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyName = json['company_name'];
    email = json['email'];
    logo = json['logo'];
    description = json['description'];
    phoneNumber = json['phone_number'];
    wallet = json['wallet'];
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
    data['state'] = this.state;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
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

class ProductVariants {
  int? id;
  int? productId;
  int? colorId;
  int? sizeId;
  int? variantQuantity;

  ProductVariants(
      {this.id,
        this.productId,
        this.colorId,
        this.sizeId,
        this.variantQuantity});

  ProductVariants.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    colorId = json['color_id'];
    sizeId = json['size_id'];
    variantQuantity = json['variant_quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_id'] = this.productId;
    data['color_id'] = this.colorId;
    data['size_id'] = this.sizeId;
    data['variant_quantity'] = this.variantQuantity;
    return data;
  }
}
