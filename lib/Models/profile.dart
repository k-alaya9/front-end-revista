class Profile {
  final id;
  final User  user;
  final cover_image;
  final bio;
  final followers_count;
  final following_count;
  final created_at;
  final updated_at;

  Profile({this.id, required this.user, this.cover_image, this.bio, this.followers_count,
      this.following_count, this.created_at, this.updated_at});

  factory Profile.fromJson(Map<dynamic, dynamic> json) {
    return Profile(
        id: json['id'],
        user: User.fromJson(json['user']),
        cover_image: json['cover_image'],
      bio: json['bio'],
      followers_count: json['followers_count'],
      following_count: json['following_count'],
    );
  }
}

class User {
  final id;
  final username;
  final email;
  final first_name;
  final last_name;
  final profile_image;
  final birth_date;
  final phone_number;
  final gender;

  User({this.id, this.username, this.email, this.first_name, this.last_name,
      this.profile_image, this.birth_date, this.phone_number, this.gender});

  factory User.fromJson(Map<dynamic,dynamic>json){
    return User(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      first_name: json['first_name'],
      last_name: json['last_name'],
      gender: json['gender'],
      birth_date: json['birth_date'],
      profile_image: json['profile_image'],
    );
  }
}