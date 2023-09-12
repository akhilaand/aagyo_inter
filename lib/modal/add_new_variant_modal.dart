class AddNewVariantModal {
  String? type;
  String? categoryId;
  String? unit;
  String? stock;
  String? price;
  String? mrp;
  String? discount;
  String? discountType;
  AddNewVariantModal({
    required this.type,
    required this.categoryId,
    required this.unit,
    required this.stock,
    required this.price,
    required this.mrp,
    required this.discount,
    required this.discountType,
  });

  Map<String, dynamic> toJson() => {
        "type": type,
        "price": price,
        "stock": stock,
        "discountType": discountType,
        "discount": discount,
    "unit":unit
      };
}

class ProductUpdateModal {
  String? stock;
  String? tag;
  String? startTime;
  String? endTime;
  List? variantDetails;

  String? productId;
  ProductUpdateModal(
      {required this.stock,
      required this.tag,
        required this.productId,
      required this.startTime,
      required this.endTime,
      required this.variantDetails});

  Map<String, dynamic> toJson() => {
    "Stock": stock,
    "Tag": tag,
    "startTime": startTime,
    "endTime": endTime,
    "variantDetails": variantDetails,
  };
}
