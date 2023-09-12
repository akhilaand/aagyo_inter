// To parse this JSON data, do
//
//     final categoryViaModuleModal = categoryViaModuleModalFromJson(jsonString);

// Dart imports:
import 'dart:convert';

CategoryViaModuleModal categoryViaModuleModalFromJson(String str) => CategoryViaModuleModal.fromJson(json.decode(str));

String categoryViaModuleModalToJson(CategoryViaModuleModal data) => json.encode(data.toJson());

class CategoryViaModuleModal {
  int? status;
  List<CategoryData>? data;

  CategoryViaModuleModal({
    this.status,
    this.data,
  });

  factory CategoryViaModuleModal.fromJson(Map<String, dynamic> json) => CategoryViaModuleModal(
    status: json["status"],
    data: json["data"] == null ? [] : List<CategoryData>.from(json["data"]!.map((x) => CategoryData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class CategoryData {
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

  CategoryData({
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

  factory CategoryData.fromJson(Map<String, dynamic> json) => CategoryData(
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
