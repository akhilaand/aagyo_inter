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
  Error? error;

  OrderStatusUpdateModel({
    this.status,
    this.message,
    this.error,
  });

  factory OrderStatusUpdateModel.fromJson(Map<String, dynamic> json) => OrderStatusUpdateModel(
    status: json["status"],
    message: json["message"],
    error: json["error"] == null ? null : Error.fromJson(json["error"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "error": error?.toJson(),
  };
}

class Error {
  List<String>? status;

  Error({
    this.status,
  });

  factory Error.fromJson(Map<String, dynamic> json) => Error(
    status: json["status"] == null ? [] : List<String>.from(json["status"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? [] : List<dynamic>.from(status!.map((x) => x)),
  };
}
