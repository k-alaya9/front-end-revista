class hestory {
  int? id;
  int? user;
  SearchedUser? searchedUser;
  String? searchTime;
  String? updatedAt;

  hestory(
      {this.id, this.user, this.searchedUser, this.searchTime, this.updatedAt});

  hestory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'];
    searchedUser = json['searched_user'] != null
        ? new SearchedUser.fromJson(json['searched_user'])
        : null;
    searchTime = json['search_time'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user'] = this.user;
    if (this.searchedUser != null) {
      data['searched_user'] = this.searchedUser!.toJson();
    }
    data['search_time'] = this.searchTime;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class SearchedUser {
  int? id;
  String? username;
  String? profileImage;
  String? firstName;
  String? lastName;

  SearchedUser(
      {this.id,
        this.username,
        this.profileImage,
        this.firstName,
        this.lastName});

  SearchedUser.fromJson(Map<String, dynamic> json) {
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