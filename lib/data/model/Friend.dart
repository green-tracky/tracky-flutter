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
  final String? email;
  final String userTag;
  final bool isFriend;

  UserProfile({
    required this.id,
    required this.username,
    required this.email,
    required this.userTag,
    required this.isFriend,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'],
      username: json['username'],
      email: json['email'] as String?,
      userTag: json['userTag'],
      isFriend: json['isFriend'] ?? false, // 없을 땐 false
    );
  }
}
