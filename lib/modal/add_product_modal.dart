import 'dart:io';

class AddProductModal{
  String? name;
  String? userId;
  String? moduleId;
  String? storeId;
  String? categoryId;
  String? subCategoryId;
  String? attributeId;
  String? libProductId;
  String? isVeg;
  String? description;
  File? image;
  String? stock;
  String? tag;
  String? startTime;
  String? endTime;
  String? variantDetails;

  AddProductModal({
    required this.name,
    required this.userId,
    required this.moduleId,
    required this.storeId,
    required this.categoryId,
    required this.subCategoryId,
    required this.attributeId,
    required this.libProductId,
    required this.isVeg,
    required this.description,
    required this.image,
    required this.stock,
    required this.tag,
    required this.startTime,
    required this.endTime,
    required this.variantDetails,});
}