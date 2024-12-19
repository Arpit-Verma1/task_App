import 'dart:convert';
/// id : "sd"
/// email : ""
/// name : ""
/// token : ""
/// createdAt : ""
/// updatedAt : ""

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));
String userModelToJson(UserModel data) => json.encode(data.toJson());
class UserModel {
  UserModel({
    String? id,
    String? email,
    String? name,
    String? token,
    DateTime? createdAt,
    DateTime? updatedAt,}){
    _id = id;
    _email = email;
    _name = name;
    _token = token;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  UserModel.fromJson(dynamic json) {
    print("decoding");
    _id = json['id']??"";
    _email = json['email']??"";
    _name = json['name']??"";
    _token = json['token']??"";
    _createdAt = DateTime.parse(json['createdAt']??"");
    _updatedAt =DateTime.parse(json['createdAt']??"");
  }
  String? _id;
  String? _email;
  String? _name;
  String? _token;
  DateTime? _createdAt;
  DateTime? _updatedAt;

  String? get id => _id;
  String? get email => _email;
  String? get name => _name;
  String? get token => _token;
  DateTime? get createdAt => _createdAt;
  DateTime? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['email'] = _email;
    map['name'] = _name;
    map['token'] = _token;
    map['createdAt'] = _createdAt?.toIso8601String();
    map['updatedAt'] = _updatedAt?.toIso8601String();
    return map;
  }

}