class notification {
  int? id;
  String? image;
  String? type;
  String? detail;
  var createdAt;
  int? user;

  notification(
      {required this.id, required this.image, required this.type, required this.detail, required this.createdAt, required this.user});

  notification.fromJson(Map<String, dynamic> json) {
    id = json['forward_id'];
    image = json['profile_image'];
    type = json['type'];
    detail = json['detail'];
    createdAt = json['created_at'];
    user = json['user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['type'] = this.type;
    data['detail'] = this.detail;
    data['created_at'] = this.createdAt;
    data['user'] = this.user;
    return data;
  }
}
