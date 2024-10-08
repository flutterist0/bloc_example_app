class Comments {
  int? postId;
  int? id;
  String? name;
  String? email;
  String? body;

  Comments({
    this.postId,
    this.id,
    this.name,
    this.email,
    this.body,
  });
  Comments.fromJson(Map<String, dynamic> json) {
    postId = json['postId']?.toInt();
    id = json['id']?.toInt();
    name = json['name']?.toString();
    email = json['email']?.toString();
    body = json['body']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['postId'] = postId;
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['body'] = body;
    return data;
  }
}
