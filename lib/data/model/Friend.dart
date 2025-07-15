/// 친구 유/무 확인
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
      id: int.tryParse(json['id'].toString()) ?? 0,
      username: json['username'] ?? '',
      profileUrl: json['profileUrl'] ?? '',
    );
  }
}

/// 친구 검색 요청
class UserProfile {
  final int id;
  final String username;
  final String profileUrl;
  final String userTag;

  UserProfile({
    required this.id,
    required this.username,
    required this.profileUrl,
    required this.userTag,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: int.tryParse(json['id'].toString()) ?? 0,
      username: json['username'] ?? '',
      profileUrl: json['profileUrl'] ?? '',
      userTag: json['userTag'] ?? '',
    );
  }
}
