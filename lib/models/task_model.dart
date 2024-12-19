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

  TaskModel(
      {this.id,
      this.uid,
      this.title,
      this.description,
      this.createdAt,
      this.updatedAt,
      this.dueAt,
      this.color});

  TaskModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? '';
    uid = json['uid'] ?? '';
    title = json['title'] ?? '';
    description = json['description'] ?? '';
    createdAt = DateTime.parse(json['createdAt'] ?? '');
    updatedAt = DateTime.parse(json['updatedAt']);
    dueAt = DateTime.parse(json['dueAt']);
    color  = hexToRgb(json['hexColor']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['uid'] = this.uid;
    data['title'] = this.title;
    data['description'] = this.description;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['deuAt'] = this.dueAt;
    data['color'] = rgbToHex(this.color!);
    return data;
  }
}
