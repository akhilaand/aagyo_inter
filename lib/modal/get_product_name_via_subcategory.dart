// To parse this JSON data, do
//
//     final getProductDetailsFromSubCategoryModal = getProductDetailsFromSubCategoryModalFromJson(jsonString);

// Dart imports:
import 'dart:convert';

GetProductDetailsFromSubCategoryModal getProductDetailsFromSubCategoryModalFromJson(String str) => GetProductDetailsFromSubCategoryModal.fromJson(json.decode(str));

String getProductDetailsFromSubCategoryModalToJson(GetProductDetailsFromSubCategoryModal data) => json.encode(data.toJson());

class GetProductDetailsFromSubCategoryModal {
  int? status;
  List<ProductDetailDatum>? data;
  List<UnitsWithAttribute>? unitsWithAttributes;

  GetProductDetailsFromSubCategoryModal({
    this.status,
    this.data,
    this.unitsWithAttributes,
  });

  factory GetProductDetailsFromSubCategoryModal.fromJson(Map<String, dynamic> json) => GetProductDetailsFromSubCategoryModal(
    status: json["status"],
    data: json["data"] == null ? [] : List<ProductDetailDatum>.from(json["data"]!.map((x) => ProductDetailDatum.fromJson(x))),
    unitsWithAttributes: json["unitsWithAttributes"] == null ? [] : List<UnitsWithAttribute>.from(json["unitsWithAttributes"]!.map((x) => UnitsWithAttribute.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "unitsWithAttributes": unitsWithAttributes == null ? [] : List<dynamic>.from(unitsWithAttributes!.map((x) => x.toJson())),
  };
}

class ProductDetailDatum {
  int? id;
  int? moduleId;
  int? categoryId;
  int? subCategoryId;
  int? attributeId;
  String? variantDetails;
  dynamic unitId;
  String? name;
  String? description;
  String? image;
  String? stock;
  String? tag;
  String? startTime;
  String? endTime;
  String? status;
  dynamic image1;
  dynamic image2;
  dynamic image3;
  dynamic image4;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? imageUrl;
  dynamic image1Url;
  dynamic image2Url;
  dynamic image3Url;
  dynamic image4Url;
  UnitsWithAttribute? attribute;
  List<UnitsWithAttribute>? unit;

  ProductDetailDatum({
    this.id,
    this.moduleId,
    this.categoryId,
    this.subCategoryId,
    this.attributeId,
    this.variantDetails,
    this.unitId,
    this.name,
    this.description,
    this.image,
    this.stock,
    this.tag,
    this.startTime,
    this.endTime,
    this.status,
    this.image1,
    this.image2,
    this.image3,
    this.image4,
    this.createdAt,
    this.updatedAt,
    this.imageUrl,
    this.image1Url,
    this.image2Url,
    this.image3Url,
    this.image4Url,
    this.attribute,
    this.unit,
  });

  factory ProductDetailDatum.fromJson(Map<String, dynamic> json) => ProductDetailDatum(
    id: json["id"],
    moduleId: json["module_id"],
    categoryId: json["category_id"],
    subCategoryId: json["subCategory_id"],
    attributeId: json["attribute_id"],
    variantDetails: json["variantDetails"],
    unitId: json["unit_id"],
    name: json["name"],
    description: json["description"],
    image: json["image"],
    stock: json["stock"],
    tag: json["tag"],
    startTime: json["startTime"],
    endTime: json["endTime"],
    status: json["status"],
    image1: json["image1"],
    image2: json["image2"],
    image3: json["image3"],
    image4: json["image4"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    imageUrl: json["image_url"],
    image1Url: json["image1_url"],
    image2Url: json["image2_url"],
    image3Url: json["image3_url"],
    image4Url: json["image4_url"],
    attribute: json["attribute"] == null ? null : UnitsWithAttribute.fromJson(json["attribute"]),
    unit: json["unit"] == null ? [] : List<UnitsWithAttribute>.from(json["unit"]!.map((x) => UnitsWithAttribute.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "module_id": moduleId,
    "category_id": categoryId,
    "subCategory_id": subCategoryId,
    "attribute_id": attributeId,
    "variantDetails": variantDetails,
    "unit_id": unitId,
    "name": name,
    "description": description,
    "image": image,
    "stock": stock,
    "tag": tag,
    "startTime": startTime,
    "endTime": endTime,
    "status": status,
    "image1": image1,
    "image2": image2,
    "image3": image3,
    "image4": image4,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "image_url": imageUrl,
    "image1_url": image1Url,
    "image2_url": image2Url,
    "image3_url": image3Url,
    "image4_url": image4Url,
    "attribute": attribute?.toJson(),
    "unit": unit == null ? [] : List<dynamic>.from(unit!.map((x) => x.toJson())),
  };
}

class UnitsWithAttribute {
  int? id;
  String? name;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? attributeId;
  List<UnitsWithAttribute>? unit;

  UnitsWithAttribute({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
    this.attributeId,
    this.unit,
  });

  factory UnitsWithAttribute.fromJson(Map<String, dynamic> json) => UnitsWithAttribute(
    id: json["id"],
    name: json["name"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    attributeId: json["attribute_id"],
    unit: json["unit"] == null ? [] : List<UnitsWithAttribute>.from(json["unit"]!.map((x) => UnitsWithAttribute.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "attribute_id": attributeId,
    "unit": unit == null ? [] : List<dynamic>.from(unit!.map((x) => x.toJson())),
  };
}
