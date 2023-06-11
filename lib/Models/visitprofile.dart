class visitprofile {
  int? id;
  User? user;
  String? coverImage;
  String? bio;
  int? isFollowing;
  int? followersCount;
  int? postsCount;
  int? followingCount;
  String? createdAt;
  String? updatedAt;

  visitprofile(
      {this.id,
        this.user,
        this.coverImage,
        this.bio,
        this.isFollowing,
        this.followersCount,
        this.postsCount,
        this.followingCount,
        this.createdAt,
        this.updatedAt});

  visitprofile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    coverImage = json['cover_image'];
    bio = json['bio'];
    isFollowing = json['is_following'];
    followersCount = json['followers_count'];
    postsCount = json['posts_count'];
    followingCount = json['following_count'];
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
    data['is_following'] = this.isFollowing;
    data['followers_count'] = this.followersCount;
    data['posts_count'] = this.postsCount;
    data['following_count'] = this.followingCount;
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
  DateTime? birthDate;
  String? phoneNumber;
  String? gender;

  User(
      {this.id,
        this.username,
        this.email,
        this.firstName,
        this.lastName,
        this.profileImage,
        this.birthDate,
        this.phoneNumber,
        this.gender});

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
    return data;
  }
}
