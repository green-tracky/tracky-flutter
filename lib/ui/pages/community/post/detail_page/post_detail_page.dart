import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tracky_flutter/_core/constants/theme.dart';
import 'package:tracky_flutter/_core/utils/text_style_util.dart';
import 'package:tracky_flutter/ui/pages/community/post/detail_page/widgets/post_detail_image_viewer.dart';
import 'package:tracky_flutter/ui/pages/community/post/detail_page/widgets/post_map_view.dart';
import 'package:tracky_flutter/ui/pages/community/post/update_page/post_update_page.dart';
import 'widgets/post_detail_reply.dart';
import 'widgets/post_detail_reply_section.dart';

class PostDetailPage extends StatefulWidget {
  final int postId;
  final String author;
  final String content;
  final String createdAt;
  final List<String> imageUrls;
  final int likeCount;
  final int commentCount;
  final List<Comment> commentList;
  // final List<LatLng>? runningPath; // (nullable) 실제 러닝 데이터 받아올 때 사용하는 것

  const PostDetailPage({
    super.key,
    required this.postId,
    required this.author,
    required this.content,
    required this.createdAt,
    required this.imageUrls,
    required this.likeCount,
    required this.commentCount,
    required this.commentList,
    // this.runningPath, // optional // 실제 러닝 데이터 받아올 때 사용하는 것
  });

  @override
  State<PostDetailPage> createState() => _PostDetailPageState();
}

class _PostDetailPageState extends State<PostDetailPage> {
  final FocusNode _commentFocusNode = FocusNode();
  final ScrollController _scrollController = ScrollController();

  late String content;
  late List<String> imageUrls;
  int commentCount = 0;
  bool isLiked = false;
  int likeCount = 0;
  bool isReplying = false;
  String replyingTo = '';

  // 더미 지도 경로 데이터
  final List<LatLng> walkingPath1 = [
    LatLng(35.159250, 129.060054),
    LatLng(35.159031, 129.059938),
    LatLng(35.158513, 129.059522),
    LatLng(35.158421, 129.058747),
    LatLng(35.158138, 129.058524),
    LatLng(35.157912, 129.058302),
    LatLng(35.157840, 129.057940),
    LatLng(35.157820, 129.057191),
    LatLng(35.157818, 129.056754),
    LatLng(35.157631, 129.056623),
    LatLng(35.157456, 129.056601),
    LatLng(35.157462, 129.057148),
    LatLng(35.156872, 129.057175),
    LatLng(35.156337, 129.057173),
    LatLng(35.155965, 129.057012),
    LatLng(35.155971, 129.056599),
    LatLng(35.156015, 129.056438),
  ];

  final List<LatLng> walkingPath2 = [
    LatLng(35.158002, 129.064046),
    LatLng(35.157890, 129.064722),
    LatLng(35.157870, 129.065122),
    LatLng(35.158590, 129.065191),
    LatLng(35.159370, 129.065167),
    LatLng(35.160482, 129.065159),
    LatLng(35.160787, 129.064387),
    LatLng(35.161105, 129.063587),
    LatLng(35.161206, 129.063276),
    LatLng(35.161429, 129.063475),
  ];

  @override
  void initState() {
    super.initState();
    content = widget.content;
    imageUrls = List.from(widget.imageUrls);
    commentCount = widget.commentCount;
    likeCount = widget.likeCount;
  }

  void handleCommentChanged(int newCount) {
    setState(() {
      commentCount = newCount;
    });
  }

  void toggleLike() {
    setState(() {
      isLiked = !isLiked;
      likeCount += isLiked ? 1 : -1;
    });
  }

  void _openImageViewer() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ImageViewerPage(imageUrls: imageUrls),
      ),
    );
  }

  @override
  void dispose() {
    _commentFocusNode.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.trackyBGreen,
      appBar: AppBar(
        backgroundColor: AppColors.trackyBGreen,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: AppColors.trackyIndigo,
            size: Gap.lGap,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          '커뮤니티',
          style: AppTextStyles.appBarTitle,
        ),
        centerTitle: true,
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(
              Icons.more_vert,
              color: AppColors.trackyIndigo,
            ),
            color: Colors.white,
            onSelected: (value) async {
              if (value == 'edit') {
                print('수정 클릭됨');
                // ✅ PostUpdatePage 호출
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => PostUpdatePage(
                      initialContent: content,
                      selectedRunning: '러닝 기록 1', // 고정값 또는 따로 관리 가능
                    ),
                  ),
                );
                if (result != null) {
                  setState(() {
                    content = result['content'];
                    if (result['imageUrl'] != null) {
                      imageUrls = [result['imageUrl']];
                    }
                  });

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        '게시글이 수정되었습니다',
                        style: styleWithColor(
                          AppTextStyles.content,
                          Colors.white,
                        ),
                      ),
                    ),
                  );
                }
              } else if (value == 'delete') {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      title: Text(
                        '삭제하시겠습니까?',
                        style: styleWithColor(
                          AppTextStyles.semiTitle,
                          AppColors.trackyIndigo,
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            '취소',
                            style: styleWithColor(
                              AppTextStyles.content,
                              Colors.grey,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context); // AlertDialog 닫기
                            Navigator.pop(context, widget.postId); // postId 반환
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  '게시글이 삭제되었습니다.',
                                  style: styleWithColor(
                                    AppTextStyles.content,
                                    Colors.white,
                                  ),
                                ),
                                behavior: SnackBarBehavior.floating,
                                duration: Duration(seconds: 2),
                              ),
                            );
                            print('삭제 완료');
                          },
                          child: Text(
                            '삭제',
                            style: styleWithColor(
                              AppTextStyles.content,
                              AppColors.trackyCancelRed,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'edit',
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '수정',
                      style: styleWithColor(
                        AppTextStyles.content,
                        AppColors.trackyIndigo,
                      ),
                    ),
                    Icon(
                      Icons.edit,
                      color: AppColors.trackyIndigo,
                      size: Gap.lGap,
                    ),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'delete',
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '삭제',
                      style: styleWithColor(
                        AppTextStyles.content,
                        AppColors.trackyCancelRed,
                      ),
                    ),
                    Icon(
                      Icons.delete_outline,
                      color: AppColors.trackyCancelRed,
                      size: Gap.lGap,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                const Divider(color: Colors.grey, thickness: 0.5, height: 0),
                const SizedBox(height: 12),

                /// 작성자 + 날짜
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 15,
                      backgroundColor: AppColors.trackyIndigo,
                      child: Icon(
                        Icons.person,
                        color: Colors.white,
                        size: Gap.lGap,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        widget.author,
                        style: AppTextStyles.semiTitle,
                      ),
                    ),
                    Text(
                      widget.createdAt,
                      style: styleWithColor(
                        AppTextStyles.plain,
                        Colors.grey,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                /// 본문 내용
                Text(
                  content,
                  style: AppTextStyles.content,
                ),
                const SizedBox(height: 12),

                /// 지도 영역
                Stack(
                  children: [
                    PostMapView(paths: [walkingPath1, walkingPath2]),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: ElevatedButton(
                        onPressed: _openImageViewer,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.trackyNeon,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          elevation: 2,
                          padding: const EdgeInsets.symmetric(
                            horizontal: Gap.mGap,
                            vertical: Gap.ssGap,
                          ), // ✅ 버튼 최소 사이즈 설정
                        ),
                        child: Text(
                          "사진보기",
                          style: styleWithColor(
                            AppTextStyles.content,
                            AppColors.trackyIndigo,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                // PostMapView(path: widget.runningPath), // 실제 러닝 데이터 받아올 때 사용하는 것
                const SizedBox(height: 12),

                /// 댓글 수 / 좋아요
                Row(
                  children: [
                    Icon(Icons.comment_outlined, size: Gap.lGap),
                    const SizedBox(width: 4),
                    Text('$commentCount'), // <- 바뀐 변수 사용
                    const SizedBox(width: 16),
                    IconButton(
                      icon: Icon(
                        isLiked ? Icons.favorite : Icons.favorite_border,
                        color: isLiked ? Colors.red : Colors.black,
                        size: Gap.lGap,
                      ),
                      onPressed: toggleLike,
                    ),
                    Text('$likeCount'),
                  ],
                ),

                const Divider(color: Colors.grey, thickness: 0.5),
                const SizedBox(height: 12),

                /// 댓글 섹션
                ReplySection(
                  initialComments: widget.commentList,
                  onCommentCountChanged: (newCount) {
                    setState(() {
                      commentCount = newCount;
                    });
                  },
                  onReplyStart: (userName) {
                    setState(() {
                      isReplying = true;
                      replyingTo = userName;
                    });
                  },
                  onReplyEnd: () {
                    setState(() {
                      isReplying = false;
                      replyingTo = '';
                    });
                  },
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),

          /// 댓글 입력창 고정
          if (!isReplying)
            Container(
              decoration: BoxDecoration(
                color: AppColors.trackyBGreen,
                border: const Border(
                  top: BorderSide(
                    color: Colors.grey,
                    width: 0.5,
                  ),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: TextEditingController(),
                      decoration: const InputDecoration(
                        hintText: '댓글을 입력하세요...',
                        border: InputBorder.none,
                      ),
                      onSubmitted: (value) {
                        // 댓글 보내기 로직 전달 필요
                      },
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.send,
                      color: AppColors.trackyIndigo,
                      size: Gap.lGap,
                    ),
                    onPressed: () {
                      // 댓글 전송 처리
                    },
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
