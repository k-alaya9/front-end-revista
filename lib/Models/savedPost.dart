class savedPost {
  int? id;
  Post? post;
  int? profile;
  String? createdAt;
  String? updatedAt;

  savedPost({this.id, this.post, this.profile, this.createdAt, this.updatedAt});

  savedPost.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    post = json['post'] != null ? new Post.fromJson(json['post']) : null;
    profile = json['profile'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.post != null) {
      data['post'] = this.post!.toJson();
    }
    data['profile'] = this.profile;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Post {
  int? id;
  Author? author;
  String? content;
  String? link;
  List? topicsDetails;
  String? image;
  int? likeId;
  int? savedPostId;
  int? likesCount;
  int? commentsCount;
  String? createdAt;
  String? updatedAt;

  Post(
      {this.id,
        this.author,
        this.content,
        this.link,
        this.topicsDetails,
        this.image,
        this.likeId,
        this.savedPostId,
        this.likesCount,
        this.commentsCount,
        this.createdAt,
        this.updatedAt});

  Post.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    author =
    json['author'] != null ? new Author.fromJson(json['author']) : null;
    content = json['content'];
    link = json['link'];
    if (json['topics_details'] != null) {
      topicsDetails=json['topics_details'];
    }
    image = json['image'];
    likeId = json['like_id'];
    savedPostId = json['saved_post_id'];
    likesCount = json['likes_count'];
    commentsCount = json['comments_count'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.author != null) {
      data['author'] = this.author!.toJson();
    }
    data['content'] = this.content;
    data['link'] = this.link;
    if (this.topicsDetails != null) {
      data['topics_details'] =
          this.topicsDetails!.map((v) => v.toJson()).toList();
    }
    data['image'] = this.image;
    data['like_id'] = this.likeId;
    data['saved_post_id'] = this.savedPostId;
    data['likes_count'] = this.likesCount;
    data['comments_count'] = this.commentsCount;
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

class TopicsDetails {
  int? id;
  String? name;
  String? image;

  TopicsDetails({this.id, this.name, this.image});

  TopicsDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    return data;
  }
}