class PostListModel {
  final int id;
  final String author;
  final String content;
  final String createdAt;
  final int likeCount;
  final int commentCount;
  final bool isLiked;
  final List<String> imageUrls;

  PostListModel({
    required this.id,
    required this.author,
    required this.content,
    required this.createdAt,
    required this.likeCount,
    required this.commentCount,
    required this.isLiked,
    required this.imageUrls,
  });

  factory PostListModel.fromMap(Map<String, dynamic> map) {
    return PostListModel(
      id: map['id'],
      author: map['user']['username'] ?? '',
      content: map['content'],
      createdAt: map['createdAt'],
      likeCount: map['likeCount'],
      commentCount: map['commentCount'],
      isLiked: map['isLiked'],
      imageUrls: List<String>.from(
        (map['pictures'] as List).map((e) => e['fileUrl']),
      ),
    );
  }
}
