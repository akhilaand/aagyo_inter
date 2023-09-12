// To parse this JSON data, do
//
//     final orderStatusUpdateModel = orderStatusUpdateModelFromJson(jsonString);

// Dart imports:
import 'dart:convert';

OrderStatusUpdateModel orderStatusUpdateModelFromJson(String str) => OrderStatusUpdateModel.fromJson(json.decode(str));

String orderStatusUpdateModelToJson(OrderStatusUpdateModel data) => json.encode(data.toJson());

class OrderStatusUpdateModel {
  int? status;
  String? message;

  OrderStatusUpdateModel({
    this.status,
    this.message,
  });

  factory OrderStatusUpdateModel.fromJson(Map<String, dynamic> json) => OrderStatusUpdateModel(
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
  };
}
