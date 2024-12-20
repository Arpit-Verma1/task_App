import 'dart:ui';

import 'package:frontend/core/constants/utils.dart';

class TaskModel {
  String? id;
  String? uid;
  String? title;
  String? description;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? dueAt;
  Color? color;
   int? isSynced;

  TaskModel(
      {this.id,
      this.uid,
      this.title,
      this.description,
      this.createdAt,
      this.updatedAt,
      this.dueAt,
      this.color,
        this.isSynced,
      });

  TaskModel.fromJson(Map<String, dynamic> json) {
    print("taks $json");
    id = json['id'] ?? '';
    uid = json['uuid'] ?? '';
    title = json['title'] ?? '';
    description = json['description'] ?? '';
    createdAt = DateTime.parse(json['createdAt'] ?? '');
    updatedAt = DateTime.parse(json['updatedAt']);
    dueAt = DateTime.parse(json['dueAt']);
    color  = hexToRgb(json['hexColor']);
    isSynced = json['isSynced']?? 1;

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['uuid'] = this.uid;
    data['title'] = this.title;
    data['description'] = this.description;
    data['createdAt'] = this.createdAt!.toIso8601String();
    data['updatedAt'] = this.updatedAt!.toIso8601String();
    data['dueAt'] = this.dueAt!.toIso8601String();
    data['hexColor'] = rgbToHex(this.color!);
    data['isSynced'] = isSynced;
    return data;
  }
}
