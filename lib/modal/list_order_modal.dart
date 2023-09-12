// To parse this JSON data, do
//
//     final listOrdersModal = listOrdersModalFromJson(jsonString);

// Dart imports:
import 'dart:convert';

ListOrdersModal listOrdersModalFromJson(String str) => ListOrdersModal.fromJson(json.decode(str));

String listOrdersModalToJson(ListOrdersModal data) => json.encode(data.toJson());

class ListOrdersModal {
  int? status;
  Data? data;

  ListOrdersModal({
    this.status,
    this.data,
  });

  factory ListOrdersModal.fromJson(Map<String, dynamic> json) => ListOrdersModal(
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
  String? address;
  String? city;
  String? state;
  int? pincode;
  String? landmark;
  String? paymentMethod;
  double? totalAmount;
  double? couponDiscount;
  String? couponCode;
  String? shippingCharges;
  String? uniqueId;
  String? paymentStatus;
  String? orderStatus;
  int? storeId;
  String? txnid;
  String? orderType;
  String? orderDate;
  String? deliveryDate;
  String? deliveryTime;
  int? deliveryManId;
  String? updatedAt;
  String? createdAt;
  List<OrderDetail>? orderDetails;
  User? userDetails;
  DelievryMan? delievryMan;
  List? nearestDeliveryAgent;

  Datum({
    this.id,
    this.userId,
    this.address,
    this.city,
    this.state,
    this.pincode,
    this.landmark,
    this.paymentMethod,
    this.totalAmount,
    this.couponDiscount,
    this.couponCode,
    this.shippingCharges,
    this.uniqueId,
    this.paymentStatus,
    this.orderStatus,
    this.storeId,
    this.txnid,
    this.orderType,
    this.orderDate,
    this.deliveryDate,
    this.deliveryTime,
    this.deliveryManId,
    this.updatedAt,
    this.createdAt,
    this.orderDetails,
    this.userDetails,
    this.delievryMan,
    this.nearestDeliveryAgent,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    userId: json["user_id"],
    address: json["address"],
    city: json["city"],
    state: json["state"],
    pincode: json["pincode"],
    landmark: json["landmark"],
    paymentMethod: json["payment_method"],
    totalAmount: double.parse(json["total_amount"].toString()),
    couponDiscount: double.parse(json["coupon_discount"].toString()),
    couponCode: json["coupon_code"],
    shippingCharges: json["shipping_charges"],
    uniqueId: json["uniqueId"],
    paymentStatus: json["payment_status"],
    orderStatus: json["order_status"],
    storeId: json["store_id"],
    txnid: json["txnid"],
    orderType: json["order_type"],
    orderDate: json["order_date"] ,
    deliveryDate: json["delivery_date"] ,
    deliveryTime: json["delivery_time"],
    deliveryManId: json["deliveryMan_id"],
    updatedAt: json["updated_at"] ,
    createdAt: json["created_at"] ,
    orderDetails: json["order_details"] == null ? [] : List<OrderDetail>.from(json["order_details"]!.map((x) => OrderDetail.fromJson(x))),
    userDetails: json["user_details"] == null ? null : User.fromJson(json["user_details"]),
    delievryMan: json["delievry_man"] == null ? null : DelievryMan.fromJson(json["delievry_man"]),
    nearestDeliveryAgent: json["order_alert_deliverymen"]
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "address": address,
    "city": city,
    "state": state,
    "pincode": pincode,
    "landmark": landmark,
    "payment_method": paymentMethod,
    "total_amount": totalAmount,
    "coupon_discount": couponDiscount,
    "coupon_code": couponCode,
    "shipping_charges": shippingCharges,
    "uniqueId": uniqueId,
    "payment_status": paymentStatus,
    "order_status": orderStatus,
    "store_id": storeId,
    "txnid": txnid,
    "order_type": orderType,
    "order_date": orderDate,
    "delivery_date": deliveryDate,
    "delivery_time": deliveryTime,
    "deliveryMan_id": deliveryManId,
    "updated_at": updatedAt,
    "created_at": createdAt,
    "order_details": orderDetails == null ? [] : List<dynamic>.from(orderDetails!.map((x) => x.toJson())),
    "user_details": userDetails?.toJson(),
    "delievry_man": delievryMan?.toJson(),
    "order_alert_deliverymen":nearestDeliveryAgent
  };
}

class DelievryMan {
  int? id;
  int? userId;
  String? zoneId;
  String? deliveryManType;
  String? identityType;
  String? identityNumber;
  String? document;
  DateTime? createdAt;
  DateTime? updatedAt;
  User? user;

  DelievryMan({
    this.id,
    this.userId,
    this.zoneId,
    this.deliveryManType,
    this.identityType,
    this.identityNumber,
    this.document,
    this.createdAt,
    this.updatedAt,
    this.user,
  });

  factory DelievryMan.fromJson(Map<String, dynamic> json) => DelievryMan(
    id: json["id"],
    userId: json["user_id"],
    zoneId: json["zone_id"],
    deliveryManType: json["deliveryManType"],
    identityType: json["identityType"],
    identityNumber: json["identityNumber"],
    document: json["document"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    user: json["user"] == null ? null : User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "zone_id": zoneId,
    "deliveryManType": deliveryManType,
    "identityType": identityType,
    "identityNumber": identityNumber,
    "document": document,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "user": user?.toJson(),
  };
}

class User {
  int? id;
  String? fName;
  String? lName;
  String? email;
  int? phone;
  dynamic emailVerifiedAt;
  String? loginType;
  String? userRole;
  dynamic empStore;
  String? status;
  String? address;
  String? dob;
  String? gender;
  String? image;
  String? createdAt;
  String? updatedAt;
  String? imageUrl;

  User({
    this.id,
    this.fName,
    this.lName,
    this.email,
    this.phone,
    this.emailVerifiedAt,
    this.loginType,
    this.userRole,
    this.empStore,
    this.status,
    this.address,
    this.dob,
    this.gender,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.imageUrl,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    fName: json["f_name"],
    lName: json["l_name"],
    email: json["email"],
    phone: json["phone"],
    emailVerifiedAt: json["email_verified_at"],
    loginType: json["login_type"],
    userRole: json["user_role"],
    empStore: json["emp_store"],
    status: json["status"],
    address: json["address"],
    dob: json["dob"],
    gender: json["gender"],
    image: json["image"],
    createdAt: json["created_at"] ,
    updatedAt: json["updated_at"] ,
    imageUrl: json["image_url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "f_name": fName,
    "l_name": lName,
    "email": email,
    "phone": phone,
    "email_verified_at": emailVerifiedAt,
    "login_type": loginType,
    "user_role": userRole,
    "emp_store": empStore,
    "status": status,
    "address": address,
    "dob": dob,
    "gender": gender,
    "image": image,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "image_url": imageUrl,
  };
}

class OrderDetail {
  int? id;
  String? productName;
  String? productCode;
  double? price;
  int? quantity;
  String? attribute;
  String? unit;
  String? size;
  String? uniqueId;
  String? status;
  String? txnid;
  String? orderDate;

  OrderDetail({
    this.id,
    this.productName,
    this.productCode,
     this.price,
    this.quantity,
    this.attribute,
    this.unit,
    this.size,
    this.uniqueId,
    this.status,
    this.txnid,
    this.orderDate,
  });

  factory OrderDetail.fromJson(Map<String, dynamic> json) => OrderDetail(
    id: json["id"],
    productName: json["product_name"],
    productCode: json["product_code"],
    price: double.parse(json["price"].toString()),
    quantity: json["quantity"],
    attribute: json["attribute"],
    unit: json["unit"],
    size: json["size"],
    uniqueId: json["uniqueId"],
    status: json["status"],
    txnid: json["txnid"],
    orderDate: json["order_date"] ,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "product_name": productName,
    "product_code": productCode,
    "price": price,
    "quantity": quantity,
    "attribute": attribute,
    "unit": unit,
    "size": size,
    "uniqueId": uniqueId,
    "status": status,
    "txnid": txnid,
    "order_date": orderDate,
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
