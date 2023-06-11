class following {
  int? id;
  Followed1? followed;

  following({this.followed,this.id});

  following.fromJson(Map<String, dynamic> json) {
    id=json['id'];
    followed = json['followed'] != null
        ? new Followed1.fromJson(json['followed'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.followed != null) {
      data['followed'] = this.followed!.toJson();
    }
    return data;
  }
}

class Followed1 {
  int? id;
  User1? user;

  Followed1({this.id, this.user});

  Followed1.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'] != null ? new User1.fromJson(json['user']) : null;
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

class User1 {
  String? username;
  String? firstName;
  String? lastName;
  String? profileImage;

  User1({this.username, this.firstName, this.lastName, this.profileImage});

  User1.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    profileImage = json['profile_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['profile_image'] = this.profileImage;
    return data;
  }
}
