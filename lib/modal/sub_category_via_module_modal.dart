// To parse this JSON data, do
//
//     final subCategoryViaModuleModal = subCategoryViaModuleModalFromJson(jsonString);

// Dart imports:
import 'dart:convert';

SubCategoryViaModuleModal subCategoryViaModuleModalFromJson(String str) => SubCategoryViaModuleModal.fromJson(json.decode(str));

String subCategoryViaModuleModalToJson(SubCategoryViaModuleModal data) => json.encode(data.toJson());

class SubCategoryViaModuleModal {
  int? status;
  List<SubCategoryData>? data;

  SubCategoryViaModuleModal({
    this.status,
    this.data,
  });

  factory SubCategoryViaModuleModal.fromJson(Map<String, dynamic> json) => SubCategoryViaModuleModal(
    status: json["status"],
    data: json["data"] == null ? [] : List<SubCategoryData>.from(json["data"]!.map((x) => SubCategoryData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class SubCategoryData {
  int? id;
  int? categoryId;
  String? name;
  String? status;
  String? priority;
  DateTime? createdAt;
  DateTime? updatedAt;

  SubCategoryData({
    this.id,
    this.categoryId,
    this.name,
    this.status,
    this.priority,
    this.createdAt,
    this.updatedAt,
  });

  factory SubCategoryData.fromJson(Map<String, dynamic> json) => SubCategoryData(
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
