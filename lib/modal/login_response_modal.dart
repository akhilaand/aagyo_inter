// To parse this JSON data, do
//
//     final loginResponseModal = loginResponseModalFromJson(jsonString);

// Dart imports:
import 'dart:convert';

LoginResponseModal loginResponseModalFromJson(String str) => LoginResponseModal.fromJson(json.decode(str));

String loginResponseModalToJson(LoginResponseModal data) => json.encode(data.toJson());

class LoginResponseModal {
  int status;
  var data;

  LoginResponseModal({
    required this.status,
     this.data,
  });

  factory LoginResponseModal.fromJson(Map<String, dynamic> json) {
    if(json["status"]==1){
      return LoginResponseModal(
        status: json["status"],
        data: Data.fromJson(json["data"]),
      );
    }else{
      return LoginResponseModal(
        status: json["status"],
        data: LoginFailedModal.fromJson("Login Failed"),
      );
    }

  }

  Map<String, dynamic> toJson() {
    if(data!=null){
      return {
        "status": status,
        "data": data?.toJson(),
      };
    }else{
      return {
        "status": status,
      };
    }

  }
}

class LoginFailedModal{
  String responseStatus;
  LoginFailedModal({required this.responseStatus});

  factory LoginFailedModal.fromJson(String response) => LoginFailedModal(
      responseStatus:response
  );
}

class Data {
  int id;
  String fName;
  String lName;
  String email;
  int phone;
  String accessToken;
  Store store;

  Data({
    required this.id,
    required this.fName,
    required this.lName,
    required this.email,
    required this.phone,
    required this.store,
    required this.accessToken
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    fName: json["f_name"],
    lName: json["l_name"],
    email: json["email"],
    phone: json["phone"],
    accessToken: json["access_token"],
    store: Store.fromJson(json["store"]),
  );

  factory Data.onLoginFailed(Map<String, dynamic> json) => Data(
    id: json["id"],
    fName: json["f_name"],
    lName: json["l_name"],
    email: json["email"],
    phone: json["phone"],
    accessToken: json["access_token"],
    store: Store.fromJson(json["store"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "f_name": fName,
    "l_name": lName,
    "email": email,
    "phone": phone,
    "store": store.toJson(),
  };
}

class Store {
  int id;
  int userId;
  int zoneId;
  int moduleId;
  String name;
  String phone;
  String email;
  String address;
  int tax;
  String minTime;
  String maxTime;
  String timeType;
  String logo;
  String cover;
  String latitude;
  String longitude;
  String status;
  DateTime createdAt;
  DateTime updatedAt;
  String logoUrl;
  String coverUrl;

  Store({
    required this.id,
    required this.userId,
    required this.zoneId,
    required this.moduleId,
    required this.name,
    required this.phone,
    required this.email,
    required this.address,
    required this.tax,
    required this.minTime,
    required this.maxTime,
    required this.timeType,
    required this.logo,
    required this.cover,
    required this.latitude,
    required this.longitude,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.logoUrl,
    required this.coverUrl,
  });

  factory Store.fromJson(Map<String, dynamic> json) => Store(
    id: json["id"],
    userId: json["user_id"],
    zoneId: json["zone_id"],
    moduleId: json["module_id"],
    name: json["name"],
    phone: json["phone"],
    email: json["email"],
    address: json["address"],
    tax: json["tax"],
    minTime: json["minTime"],
    maxTime: json["maxTime"],
    timeType: json["timeType"],
    logo: json["logo"],
    cover: json["cover"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    logoUrl: json["logo_url"],
    coverUrl: json["cover_url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "zone_id": zoneId,
    "module_id": moduleId,
    "name": name,
    "phone": phone,
    "email": email,
    "address": address,
    "tax": tax,
    "minTime": minTime,
    "maxTime": maxTime,
    "timeType": timeType,
    "logo": logo,
    "cover": cover,
    "latitude": latitude,
    "longitude": longitude,
    "status": status,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "logo_url": logoUrl,
    "cover_url": coverUrl,
  };
}
