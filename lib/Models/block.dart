class block {
  int? id;
  Blocked? blocked;

  block({this.id, this.blocked});

  block.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    blocked =
    json['blocked'] != null ? new Blocked.fromJson(json['blocked']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.blocked != null) {
      data['blocked'] = this.blocked!.toJson();
    }
    return data;
  }
}

class Blocked {
  int? id;
  User? user;
  String? coverImage;
  String? bio;
  int? followersCount;
  int? followingCount;
  int? postsCount;
  String? createdAt;
  String? updatedAt;

  Blocked(
      {this.id,
        this.user,
        this.coverImage,
        this.bio,
        this.followersCount,
        this.followingCount,
        this.postsCount,
        this.createdAt,
        this.updatedAt});

  Blocked.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    coverImage = json['cover_image'];
    bio = json['bio'];
    followersCount = json['followers_count'];
    followingCount = json['following_count'];
    postsCount = json['posts_count'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['cover_image'] = this.coverImage;
    data['bio'] = this.bio;
    data['followers_count'] = this.followersCount;
    data['following_count'] = this.followingCount;
    data['posts_count'] = this.postsCount;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class User {
  int? id;
  String? username;
  String? email;
  String? firstName;
  String? lastName;
  String? profileImage;
  String? birthDate;
  String? phoneNumber;
  var gender;
  bool? isActive;

  User(
      {this.id,
        this.username,
        this.email,
        this.firstName,
        this.lastName,
        this.profileImage,
        this.birthDate,
        this.phoneNumber,
        this.gender,
        this.isActive});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    profileImage = json['profile_image'];
    birthDate = json['birth_date'];
    phoneNumber = json['phone_number'];
    gender = json['gender'];
    isActive = json['is_active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['email'] = this.email;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['profile_image'] = this.profileImage;
    data['birth_date'] = this.birthDate;
    data['phone_number'] = this.phoneNumber;
    data['gender'] = this.gender;
    data['is_active'] = this.isActive;
    return data;
  }
}
