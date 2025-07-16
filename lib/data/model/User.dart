class User {
  final int id;
  final String? loginId;
  final String? username;
  final String? profileUrl;
  final double? height;
  final double? weight;
  final String? gender;
  final String? location;
  final String? letter;
  final String? provider;
  final String? userTag;
  final String? fcmToken;
  final String? createdAt;
  final String? idToken;

  User({
    required this.id,
    required this.loginId,
    required this.username,
    required this.profileUrl,
    required this.height,
    required this.weight,
    required this.gender,
    required this.location,
    required this.letter,
    required this.provider,
    required this.userTag,
    required this.fcmToken,
    required this.createdAt,
    required this.idToken,
  });

  factory User.fromMap(Map<String, dynamic> data) {
    final user = data['user'] as Map<String, dynamic>;
    return User(
      id: user['id'],
      loginId: user['loginId'],
      username: user['username'],
      profileUrl: user['profileUrl'],
      height: (user['height'] ?? 0).toDouble(),
      weight: (user['weight'] ?? 0).toDouble(),
      gender: user['gender'],
      location: user['location'],
      letter: user['letter'],
      provider: user['provider'],
      userTag: user['userTag'],
      fcmToken: user['fcmToken'],
      createdAt: user['createdAt'],
      idToken: data['idToken'],
    );
  }

  User copyWith({
    String? gender,
    double? height,
    double? weight,
    String? location,
    String? letter,
  }) {
    return User(
      id: id,
      loginId: loginId,
      username: username,
      profileUrl: profileUrl,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      gender: gender ?? this.gender,
      location: location ?? this.location,
      letter: letter ?? this.letter,
      provider: provider,
      userTag: userTag,
      fcmToken: fcmToken,
      createdAt: createdAt,
      idToken: idToken,
    );
  }

  @override
  String toString() {
    return 'User(id: $id, username: $username, tag: $userTag)';
  }
}
