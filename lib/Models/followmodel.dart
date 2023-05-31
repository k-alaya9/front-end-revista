import 'dart:convert';

class follow {
  final id;
  final username;
  final name;
  final nameurl;

  follow({this.id, this.username, this.name, this.nameurl});

  factory follow.fromJson(Map<dynamic, dynamic> json) {
    return follow(
        id: json['id'],
        name: json['name'],
        username: json['username'],
        nameurl: json['image_profile']);
  }
}
