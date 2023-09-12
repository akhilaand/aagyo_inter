// To parse this JSON data, do
//
//     final varientModal = varientModalFromJson(jsonString);

// Dart imports:
import 'dart:convert';

VarientModal varientModalFromJson(String str) => VarientModal.fromJson(json.decode(str));

String varientModalToJson(VarientModal data) => json.encode(data.toJson());

class VarientModal {
  String? type;
  String? unit;
  String? price;
  String? stock;
  String? discountType;
  String? discount;

  VarientModal({
    this.type,
    this.unit,
    this.price,
    this.stock,
    this.discountType,
    this.discount,
  });

  factory VarientModal.fromJson(Map<String, dynamic> json) => VarientModal(
    type: json["type"],
    unit: json["unit"],
    price: json["price"],
    stock: json["stock"],
    discountType: json["discountType"],
    discount: json["discount"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "unit": unit,
    "price": price,
    "stock": stock,
    "discountType": discountType,
    "discount": discount,
  };
}
