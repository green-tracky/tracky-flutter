import 'package:dio/dio.dart';
import 'package:tracky_flutter/ui/pages/community/post/detail_page/widgets/post_detail_vm.dart';

class PostDetailReplyRepository {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://your-api-url.com',
      headers: {'Content-Type': 'application/json'},
    ),
  );

  Future<List<CommentModel>> fetchComments(int postId) async {
    final response = await _dio.get('/s/api/community/posts/$postId/comments');
    if (response.statusCode == 200) {
      final List<dynamic> data = response.data['data']?['comments'] ?? [];
      return data.map((e) => CommentModel.fromMap(e)).toList();
    }
    throw Exception('댓글 목록 조회 실패: ${response.statusCode}');
  }

  Future<CommentModel> postComment(int postId, String content, {int? parentId}) async {
    final response = await _dio.post(
      '/s/api/community/posts/$postId/comments',
      data: {
        'parentId': parentId,
        'content': content,
      },
    );
    if (response.statusCode == 200) {
      final data = response.data['data'];
      return CommentModel.fromMap(data);
    } else {
      throw Exception('댓글 등록 실패');
    }
  }

  Future<void> deleteComment(int postId, int commentId) async {
    final response = await _dio.delete('/s/api/community/posts/$postId/comments/$commentId');
    if (response.statusCode != 200) {
      throw Exception('댓글 삭제 실패');
    }
  }
}
