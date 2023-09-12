// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'dart:convert';

ProductModel productModelFromJson(String str) => ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  int? status;
  Data? data;

  ProductModel({
    this.status,
    this.data,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    status: json["status"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data?.toJson(),
  };
}

class Data {
  int? currentPage;
  List<ProductDatum>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Link>? links;
  String? nextPageUrl;
  String? path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;

  Data({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    currentPage: json["current_page"],
    data: json["data"] == null ? [] : List<ProductDatum>.from(json["data"]!.map((x) => ProductDatum.fromJson(x))),
    firstPageUrl: json["first_page_url"],
    from: json["from"],
    lastPage: json["last_page"],
    lastPageUrl: json["last_page_url"],
    links: json["links"] == null ? [] : List<Link>.from(json["links"]!.map((x) => Link.fromJson(x))),
    nextPageUrl: json["next_page_url"],
    path: json["path"],
    perPage: json["per_page"],
    prevPageUrl: json["prev_page_url"],
    to: json["to"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "productData": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "first_page_url": firstPageUrl,
    "from": from,
    "last_page": lastPage,
    "last_page_url": lastPageUrl,
    "links": links == null ? [] : List<dynamic>.from(links!.map((x) => x.toJson())),
    "next_page_url": nextPageUrl,
    "path": path,
    "per_page": perPage,
    "prev_page_url": prevPageUrl,
    "to": to,
    "total": total,
  };
}

class Link {
  String? url;
  String? label;
  bool? active;

  Link({
    this.url,
    this.label,
    this.active,
  });

  factory Link.fromJson(Map<String, dynamic> json) => Link(
    url: json["url"],
    label: json["label"],
    active: json["active"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "label": label,
    "active": active,
  };
}

class ProductDatum {
  int? id;
  int? userId;
  int? moduleId;
  int? storeId;
  int? categoryId;
  int? subCategoryId;
  dynamic addonId;
  int? attributeId;
  dynamic unitId;
  int? libProductId;
  String? name;
  String? veg;
  String? variantDetails;
  String? description;
  String? image;
  String? stock;
  dynamic price;
  dynamic discountType;
  dynamic discount;
  String? tag;
  String? startTime;
  String? endTime;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? imageUrl;
  Module? module;
  dynamic addon;
  Attribute? attribute;
  dynamic unit;
  CentrallibProduct? centrallibProduct;
  Category? category;
  SubCategory? subCategory;

  ProductDatum({
    this.id,
    this.userId,
    this.moduleId,
    this.storeId,
    this.categoryId,
    this.subCategoryId,
    this.addonId,
    this.attributeId,
    this.unitId,
    this.libProductId,
    this.name,
    this.veg,
    this.variantDetails,
    this.description,
    this.image,
    this.stock,
    this.price,
    this.discountType,
    this.discount,
    this.tag,
    this.startTime,
    this.endTime,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.imageUrl,
    this.module,
    this.addon,
    this.attribute,
    this.unit,
    this.centrallibProduct,
    this.category,
    this.subCategory,
  });

  factory ProductDatum.fromJson(Map<String, dynamic> json) => ProductDatum(
    id: json["id"],
    userId: json["user_id"],
    moduleId: json["module_id"],
    storeId: json["store_id"],
    categoryId: json["category_id"],
    subCategoryId: json["subCategory_id"],
    addonId: json["addon_id"],
    attributeId: json["attribute_id"],
    unitId: json["unit_id"],
    libProductId: json["lib_product_id"],
    name: json["name"],
    veg: json["veg"],
    variantDetails: json["variantDetails"],
    description: json["description"],
    image: json["image"],
    stock: json["stock"],
    price: json["price"],
    discountType: json["discountType"],
    discount: json["discount"],
    tag: json["tag"],
    startTime: json["startTime"],
    endTime: json["endTime"],
    status: json["status"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    imageUrl: json["image_url"],
    module: json["module"] == null ? null : Module.fromJson(json["module"]),
    addon: json["addon"],
    attribute: json["attribute"] == null ? null : Attribute.fromJson(json["attribute"]),
    unit: json["unit"],
    centrallibProduct: json["centrallib_product"] == null ? null : CentrallibProduct.fromJson(json["centrallib_product"]),
    category: json["category"] == null ? null : Category.fromJson(json["category"]),
    subCategory: json["sub_category"] == null ? null : SubCategory.fromJson(json["sub_category"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "module_id": moduleId,
    "store_id": storeId,
    "category_id": categoryId,
    "subCategory_id": subCategoryId,
    "addon_id": addonId,
    "attribute_id": attributeId,
    "unit_id": unitId,
    "lib_product_id": libProductId,
    "name": name,
    "veg": veg,
    "variantDetails": variantDetails,
    "description": description,
    "image": image,
    "stock": stock,
    "price": price,
    "discountType": discountType,
    "discount": discount,
    "tag": tag,
    "startTime": startTime,
    "endTime": endTime,
    "status": status,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "image_url": imageUrl,
    "module": module?.toJson(),
    "addon": addon,
    "attribute": attribute?.toJson(),
    "unit": unit,
    "centrallib_product": centrallibProduct?.toJson(),
    "category": category?.toJson(),
    "sub_category": subCategory?.toJson(),
  };
}

class Attribute {
  int? id;
  String? name;
  DateTime? createdAt;
  DateTime? updatedAt;

  Attribute({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
  });

  factory Attribute.fromJson(Map<String, dynamic> json) => Attribute(
    id: json["id"],
    name: json["name"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}

class Category {
  int? id;
  int? userId;
  int? moduleId;
  String? cateBy;
  String? name;
  String? status;
  String? priority;
  String? image;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? imageUrl;

  Category({
    this.id,
    this.userId,
    this.moduleId,
    this.cateBy,
    this.name,
    this.status,
    this.priority,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.imageUrl,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    userId: json["user_id"],
    moduleId: json["module_id"],
    cateBy: json["cate_by"],
    name: json["name"],
    status: json["status"],
    priority: json["priority"],
    image: json["image"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    imageUrl: json["image_url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "module_id": moduleId,
    "cate_by": cateBy,
    "name": name,
    "status": status,
    "priority": priority,
    "image": image,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "image_url": imageUrl,
  };
}

class CentrallibProduct {
  int? id;
  String? imageUrl;
  dynamic image1Url;
  dynamic image2Url;
  dynamic image3Url;
  dynamic image4Url;

  CentrallibProduct({
    this.id,
    this.imageUrl,
    this.image1Url,
    this.image2Url,
    this.image3Url,
    this.image4Url,
  });

  factory CentrallibProduct.fromJson(Map<String, dynamic> json) => CentrallibProduct(
    id: json["id"],
    imageUrl: json["image_url"],
    image1Url: json["image1_url"],
    image2Url: json["image2_url"],
    image3Url: json["image3_url"],
    image4Url: json["image4_url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "image_url": imageUrl,
    "image1_url": image1Url,
    "image2_url": image2Url,
    "image3_url": image3Url,
    "image4_url": image4Url,
  };
}

class Module {
  int? id;
  int? userId;
  String? name;
  String? type;
  String? description;
  String? status;
  String? theme;
  String? icon;
  String? thumbnail;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? thumbnailUrl;
  String? iconUrl;

  Module({
    this.id,
    this.userId,
    this.name,
    this.type,
    this.description,
    this.status,
    this.theme,
    this.icon,
    this.thumbnail,
    this.createdAt,
    this.updatedAt,
    this.thumbnailUrl,
    this.iconUrl,
  });

  factory Module.fromJson(Map<String, dynamic> json) => Module(
    id: json["id"],
    userId: json["user_id"],
    name: json["name"],
    type: json["type"],
    description: json["description"],
    status: json["status"],
    theme: json["theme"],
    icon: json["icon"],
    thumbnail: json["thumbnail"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    thumbnailUrl: json["thumbnail_url"],
    iconUrl: json["icon_url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "name": name,
    "type": type,
    "description": description,
    "status": status,
    "theme": theme,
    "icon": icon,
    "thumbnail": thumbnail,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "thumbnail_url": thumbnailUrl,
    "icon_url": iconUrl,
  };
}

class SubCategory {
  int? id;
  int? categoryId;
  String? name;
  String? status;
  String? priority;
  DateTime? createdAt;
  DateTime? updatedAt;

  SubCategory({
    this.id,
    this.categoryId,
    this.name,
    this.status,
    this.priority,
    this.createdAt,
    this.updatedAt,
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
    id: json["id"],
    categoryId: json["category_id"],
    name: json["name"],
    status: json["status"],
    priority: json["priority"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "category_id": categoryId,
    "name": name,
    "status": status,
    "priority": priority,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
