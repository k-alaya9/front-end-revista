class live {
  int? id;
  Streamer? streamer;
  String? title;
  String? description;
  String? createdAt;

  live({this.id, this.streamer, this.title, this.description, this.createdAt});

  live.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    streamer = json['streamer'] != null
        ? new Streamer.fromJson(json['streamer'])
        : null;
    title = json['title'];
    description = json['description'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.streamer != null) {
      data['streamer'] = this.streamer!.toJson();
    }
    data['title'] = this.title;
    data['description'] = this.description;
    data['created_at'] = this.createdAt;
    return data;
  }
}

class Streamer {
  int? id;
  String? username;
  String? email;
  String? firstName;
  String? lastName;
  String? profileImage;
  var birthDate;
  var phoneNumber;
  String? gender;
  bool? isActive;
  bool? isOnline;

  Streamer(
      {this.id,
        this.username,
        this.email,
        this.firstName,
        this.lastName,
        this.profileImage,
        this.birthDate,
        this.phoneNumber,
        this.gender,
        this.isActive,
        this.isOnline});

  Streamer.fromJson(Map<String, dynamic> json) {
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
    isOnline = json['is_online'];
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
    data['is_online'] = this.isOnline;
    return data;
  }
}
