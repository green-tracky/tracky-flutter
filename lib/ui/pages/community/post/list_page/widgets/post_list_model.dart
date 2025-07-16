class PostListModel {
  final int id;
  final String author;
  final String profileUrl;
  final String content;
  final String createdAt;
  final int likeCount;
  final int commentCount;
  final bool isLiked;
  final List<String> imageUrls;
  final String thumbnailImage;

  PostListModel({
    required this.id,
    required this.author,
    required this.profileUrl,
    required this.content,
    required this.createdAt,
    required this.likeCount,
    required this.commentCount,
    required this.isLiked,
    required this.imageUrls,
    required this.thumbnailImage,
  });

  factory PostListModel.fromMap(Map<String, dynamic> map) {
    final pictures = map['pictures'] as List? ?? [];

    final List<String> imageUrls = pictures
        .map((e) => e is Map<String, dynamic> && e['fileUrl'] != null ? e['fileUrl'] as String : '')
        .where((url) => url.isNotEmpty)
        .toList();

    final String thumbnail = imageUrls.isNotEmpty ? imageUrls.first : 'assets/images/mountain.jpg';

    return PostListModel(
      id: map['id'] ?? 0,
      author: map['user']?['username'] ?? '',
      profileUrl: map['user']?['profileUrl'] ?? '',
      content: map['content'] ?? '',
      createdAt: map['createdAt'] ?? '',
      likeCount: map['likeCount'] ?? 0,
      commentCount: map['commentCount'] ?? 0,
      isLiked: map['isLiked'] ?? false,
      imageUrls: imageUrls,
      thumbnailImage: thumbnail,
    );
  }
}
