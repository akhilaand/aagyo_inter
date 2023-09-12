// To parse this JSON data, do
//
//     final overViewResponseModal = overViewResponseModalFromJson(jsonString);

// Dart imports:
import 'dart:convert';

OverViewResponseModal overViewResponseModalFromJson(String str) => OverViewResponseModal.fromJson(json.decode(str));

String overViewResponseModalToJson(OverViewResponseModal data) => json.encode(data.toJson());

class OverViewResponseModal {
  int? status;
  Overview? overview;

  OverViewResponseModal({
    this.status,
    this.overview,
  });

  factory OverViewResponseModal.fromJson(Map<String, dynamic> json) => OverViewResponseModal(
    status: json["status"],
    overview: Overview.fromJson(json["overview"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "overview": overview?.toJson(),
  };
}

class Overview {
  int? totalSales;
  int? allCustomers;
  int? totalOrders;
  int? totalProducts;

  Overview({
    this.totalSales,
    this.allCustomers,
    this.totalOrders,
    this.totalProducts,
  });

  factory Overview.fromJson(Map<String, dynamic> json) => Overview(
    totalSales: json["total_sales"]??0,
    allCustomers: json["all_customers"]??0,
    totalOrders: json["total_orders"]??0,
    totalProducts: json["total_products"]??0,
  );

  Map<String, dynamic> toJson() => {
    "total_sales": totalSales,
    "all_customers": allCustomers,
    "total_orders": totalOrders,
    "total_products": totalProducts,
  };
}
