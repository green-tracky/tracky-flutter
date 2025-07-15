class Friend {
  final int id;
  final String username;
  final String profileUrl;

  Friend({
    required this.id,
    required this.username,
    required this.profileUrl,
  });

  factory Friend.fromJson(Map<String, dynamic> json) {
    return Friend(
      id: json['id'],
      username: json['username'],
      profileUrl: json['profileUrl'],
    );
  }
}
