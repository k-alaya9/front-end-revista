class chat {
  int? id;
  User? user;
  LastMessage? lastMessage;


  chat({this.id, this.user, this.lastMessage});

  chat.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    lastMessage = json['last_message'] != null
        ? new LastMessage.fromJson(json['last_message'])
        : null;

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.lastMessage != null) {
      data['last_message'] = this.lastMessage!.toJson();
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

class LastMessage {
  int? id;
  String? authorUsername;
  String? type;
  String? text;
  String? createdAt;
  LastMessage({this.id, this.authorUsername, this.type, this.text,this.createdAt});

  LastMessage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    authorUsername = json['author_username'];
    type = json['type'];
    text = json['text'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['author_username'] = this.authorUsername;
    data['type'] = this.type;
    data['text'] = this.text;
    data['created_at'] = this.createdAt;
    return data;
  }
}
