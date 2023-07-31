import 'package:revista/Models/topic.dart';

class post {
  int? id;
  Author? author;
  String? content;
  String? link;
  List<topicItem>? topics;
  String? image;
  int? likesCount;
  int? commentsCount;
  String? createdAt;
  String? updatedAt;

  post(
      {this.id,
        this.author,
        this.content,
        this.link,
        this.topics,
        this.image,
        this.likesCount,
        this.commentsCount,
        this.createdAt,
        this.updatedAt});

  post.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    author =
    json['author'] != null ? new Author.fromJson(json['author']) : null;
    content = json['content'];
    link = json['link'];
    // topics = json['topics'];
    image = json['image'];
    likesCount = json['likes_count'];
    commentsCount = json['comments_count'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.author != null) {
      data['author'] = this.author!.toJson();
    }
    data['content'] = this.content;
    data['link'] = this.link;
    data['topics'] = this.topics;
    data['image'] = this.image;
    data['likes_count'] = this.likesCount;
    data['comments_count'] = this.commentsCount;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Author {
  int? id;
  User? user;

  Author({this.id, this.user});

  Author.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? username;
  String? profileImage;
  String? firstName;
  String? lastName;

  User(
      {this.id,
        this.username,
        this.profileImage,
        this.firstName,
        this.lastName});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    profileImage = json['profile_image'];
    firstName = json['first_name'];
    lastName = json['last_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['profile_image'] = this.profileImage;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    return data;
  }
}
