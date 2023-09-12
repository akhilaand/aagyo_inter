// To parse this JSON data, do
//
//     final productEditModel = productEditModelFromJson(jsonString);

// Dart imports:
import 'dart:convert';

ProductEditModel productEditModelFromJson(String str) => ProductEditModel.fromJson(json.decode(str));

String productEditModelToJson(ProductEditModel data) => json.encode(data.toJson());

class ProductEditModel {
  String? stock;
  String? tag;
  String? startTime;
  String? endTime;
  List<VariantDetail>? variantDetails;

  ProductEditModel({
    this.stock,
    this.tag,
    this.startTime,
    this.endTime,
    this.variantDetails,
  });

  factory ProductEditModel.fromJson(Map<String, dynamic> json) => ProductEditModel(
    stock: json["Stock"],
    tag: json["Tag"],
    startTime: json["startTime"],
    endTime: json["endTime"],
    variantDetails: json["variantDetails"] == null ? [] : List<VariantDetail>.from(json["variantDetails"]!.map((x) => VariantDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Stock": stock,
    "Tag": tag,
    "startTime": startTime,
    "endTime": endTime,
    "variantDetails": variantDetails == null ? [] : List<dynamic>.from(variantDetails!.map((x) => x.toJson())),
  };
}

class VariantDetail {
  String? type;
  String? price;
  String? stock;
  String? discountType;
  String? discount;

  VariantDetail({
    this.type,
    this.price,
    this.stock,
    this.discountType,
    this.discount,
  });

  factory VariantDetail.fromJson(Map<String, dynamic> json) => VariantDetail(
    type: json["type"],
    price: json["price"],
    stock: json["stock"],
    discountType: json["discountType"],
    discount: json["discount"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "price": price,
    "stock": stock,
    "discountType": discountType,
    "discount": discount,
  };
}
