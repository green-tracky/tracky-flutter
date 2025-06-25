import 'package:flutter/material.dart';

class Post {
  final String username;
  final String content;
  final DateTime date;
  int likes;
  List<String> comments;

  Post({required this.username, required this.content, required this.date, this.likes = 0, this.comments = const []});
}

class PostListViewModel extends ChangeNotifier {
  final String currentUser = 'ssar';

  final List<Post> _posts = [
    Post(username: 'cos', content: '오늘 러닝 5km 완주!', date: DateTime(2025, 6, 18, 17, 0)),
    Post(username: 'love', content: '러닝 끝나고 먹는 샐러드가 꿀맛~', date: DateTime(2025, 6, 17, 15, 0)),
    Post(username: 'green', content: '비 오는 날에도 런~', date: DateTime(2025, 6, 16, 9, 30)),
    Post(username: 'haha', content: '새 신발 신고 러닝했어요!', date: DateTime(2025, 6, 15, 19, 0)),
  ];

  List<Post> get posts => List.unmodifiable(_posts);

  void addComment(int index, String comment) {
    _posts[index].comments = [..._posts[index].comments, comment];
    notifyListeners();
  }

  void toggleLike(int index) {
    _posts[index].likes += 1;
    notifyListeners();
  }
}
