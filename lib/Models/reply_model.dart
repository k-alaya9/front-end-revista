class reply {
  int? id;
  Comment? comment;
  Author? author;
  String? content;
  String? createdAt;
  String? updatedAt;

  reply(
      {this.id,
        this.comment,
        this.author,
        this.content,
        this.createdAt,
        this.updatedAt});

  reply.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    comment =
    json['comment'] != null ? new Comment.fromJson(json['comment']) : null;
    author =
    json['author'] != null ? new Author.fromJson(json['author']) : null;
    content = json['content'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.comment != null) {
      data['comment'] = this.comment!.toJson();
    }
    if (this.author != null) {
      data['author'] = this.author!.toJson();
    }
    data['content'] = this.content;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Comment {
  int? id;
  int? post;
  Author? author;
  String? content;
  String? createdAt;
  String? updatedAt;

  Comment(
      {this.id,
        this.post,
        this.author,
        this.content,
        this.createdAt,
        this.updatedAt});

  Comment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    post = json['post'];
    author =
    json['author'] != null ? new Author.fromJson(json['author']) : null;
    content = json['content'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['post'] = this.post;
    if (this.author != null) {
      data['author'] = this.author!.toJson();
    }
    data['content'] = this.content;
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