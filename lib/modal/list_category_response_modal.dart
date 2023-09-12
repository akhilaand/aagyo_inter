// To parse this JSON data, do
//
//     final listCategoryResponseModal = listCategoryResponseModalFromJson(jsonString);

// Dart imports:
import 'dart:convert';

ListCategoryResponseModal listCategoryResponseModalFromJson(String str) => ListCategoryResponseModal.fromJson(json.decode(str));

String listCategoryResponseModalToJson(ListCategoryResponseModal data) => json.encode(data.toJson());

class ListCategoryResponseModal {
  int? status;
  Data? data;

  ListCategoryResponseModal({
    this.status,
    this.data,
  });

  factory ListCategoryResponseModal.fromJson(Map<String, dynamic> json) => ListCategoryResponseModal(
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
  List<Datum>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Link>? links;
  dynamic nextPageUrl;
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
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
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
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
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

class Datum {
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
  List<SubCategory>? subCategory;

  Datum({
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
    this.subCategory,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
    subCategory: json["sub_category"] == null ? [] : List<SubCategory>.from(json["sub_category"]!.map((x) => SubCategory.fromJson(x))),
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
    "sub_category": subCategory == null ? [] : List<dynamic>.from(subCategory!.map((x) => x.toJson())),
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
