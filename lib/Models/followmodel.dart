class follow {
  int? id;
  Followed? followed;

  follow({this.followed,this.id});

  follow.fromJson(Map<String, dynamic> json) {
    id =json['id'];
    followed = json['follower'] != null
        ?  Followed.fromJson(json['follower'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.followed != null) {
      data['follower'] = this.followed!.toJson();
    }
    return data;
  }
}

class Followed {
  int? id;
  User? user;

  Followed({this.id, this.user});

  Followed.fromJson(Map<String, dynamic> json) {
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
  String? username;
  String? firstName;
  String? lastName;
  String? profileImage;

  User({this.username, this.firstName, this.lastName, this.profileImage});

  User.fromJson(Map<String, dynamic> json) {
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
