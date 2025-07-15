import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tracky_flutter/ui/pages/community/post/detail_page/widgets/post_detail_reply.dart';

class PostDetailReplyRepository {
  final String baseUrl = 'https://your-api-url.com';

  Future<List<Comment>> fetchComments(int postId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/s/api/community/posts/$postId/comments'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body)['data'];
      return data.map((e) => Comment.fromMap(e)).toList();
    } else {
      throw Exception('댓글 목록 조회 실패');
    }
  }

  Future<Comment> postComment(int postId, String content, {int? parentId}) async {
    final response = await http.post(
      Uri.parse('$baseUrl/community/posts/comments'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'POSTId': postId,
        'content': content,
        'parentId': parentId,
      }),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body)['data'];
      return Comment.fromMap(data);
    } else {
      throw Exception('댓글 등록 실패');
    }
  }
}
