
class TaskModel {
  String? id;
  String? uid;
  String? title;
  String? description;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? deuAt;

  TaskModel(
      {this.id,
        this.uid,
        this.title,
        this.description,
        this.createdAt,
        this.updatedAt,
        this.deuAt});

  TaskModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ??'';
    uid = json['uid'] ??'';
    title = json['title']??'';
    description = json['description']??'';
    createdAt = DateTime.parse(json['createdAt']??'');
    updatedAt = DateTime.parse(json['updatedAt']);
    deuAt = DateTime.parse(json['dueAt']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['uid'] = this.uid;
    data['title'] = this.title;
    data['description'] = this.description;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['deuAt'] = this.deuAt;
    return data;
  }
}
