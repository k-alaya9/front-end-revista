class comment {
  int? id;
  int? post;
  int? author;
  String? content;
  String? createdAt;
  String? updatedAt;

  comment(
      {this.id,
        this.post,
        this.author,
        this.content,
        this.createdAt,
        this.updatedAt});

  comment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    post = json['post'];
    author = json['author'];
    content = json['content'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['post'] = this.post;
    data['author'] = this.author;
    data['content'] = this.content;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}