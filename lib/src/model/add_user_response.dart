class AddUserModel {
  String? createdAt;
  String? id;
  String? job;
  String? name;

  AddUserModel({this.createdAt, this.id, this.job, this.name});

  factory AddUserModel.fromJson(Map<String, dynamic> json) {
    return AddUserModel(
      createdAt: json['createdAt'],
      id: json['id'],
      job: json['job'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdAt'] = this.createdAt;
    data['id'] = this.id;
    data['job'] = this.job;
    data['name'] = this.name;
    return data;
  }
}
