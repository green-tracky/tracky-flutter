import 'package:flutter/material.dart';

class Comment {
  final int id;
  final int postId;
  final int userId;
  final String username;
  String content;
  final int? parentId;
  final String createdAt;
  List<Comment> children;

  // UI 전용 필드
  bool isRepliesExpanded;
  int repliesPage;
  bool isReplying;

  Comment({
    required this.id,
    required this.postId,
    required this.userId,
    required this.username,
    required this.content,
    required this.parentId,
    required this.createdAt,
    this.children = const [],
    this.isRepliesExpanded = false,
    this.repliesPage = 1,
    this.isReplying = false,
  });

  factory Comment.fromMap(Map<String, dynamic> map) {
    return Comment(
      id: map['id'],
      postId: map['postId'], // ✅ POSTId → postId 오타 수정
      userId: map['userId'],
      username: map['username'] ?? '',
      content: map['content'],
      parentId: map['parentId'],
      createdAt: map['createdAt'],
      children: (map['children'] as List<dynamic>?)?.map((e) => Comment.fromMap(e)).toList() ?? [],
    );
  }

  Comment copyWith({
    int? id,
    int? postId,
    int? userId,
    String? username,
    String? content,
    int? parentId,
    String? createdAt,
    List<Comment>? children,
    bool? isRepliesExpanded,
    int? repliesPage,
    bool? isReplying,
  }) {
    return Comment(
      id: id ?? this.id,
      postId: postId ?? this.postId,
      userId: userId ?? this.userId,
      username: username ?? this.username,
      content: content ?? this.content,
      parentId: parentId ?? this.parentId,
      createdAt: createdAt ?? this.createdAt,
      children: children ?? List.from(this.children),
      isRepliesExpanded: isRepliesExpanded ?? this.isRepliesExpanded,
      repliesPage: repliesPage ?? this.repliesPage,
      isReplying: isReplying ?? this.isReplying,
    );
  }
}
