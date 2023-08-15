class search {
  int? id;
  String? username;
  String? profileImage;
  String? firstName;
  String? lastName;
  search(
      {this.id,
        this.username,
        this.profileImage,
        this.firstName,
        this.lastName});

  search.fromJson(Map<String, dynamic> json) {
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