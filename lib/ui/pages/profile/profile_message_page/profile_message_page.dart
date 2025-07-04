import 'package:flutter/material.dart';

class ProfileMessagePage extends StatefulWidget {
  const ProfileMessagePage({super.key});

  @override
  State<ProfileMessagePage> createState() => _ProfileMessagePageState();
}

class _ProfileMessagePageState extends State<ProfileMessagePage> {
  List<Map<String, dynamic>> notifications = [
    {
      'type': 'challenge',
      'title': '🏃‍♂️ 챌린지 초대',
      'message': '지수님이 5일 챌린지에 초대했어요!',
    },
    {
      'type': 'friend',
      'title': '👥 친구 추가 요청',
      'message': '민수님이 친구 요청을 보냈어요!',
    },
    {
      'type': 'challenge',
      'title': '🏃‍♀️ 챌린지 초대',
      'message': '영희님이 러닝 챌린지에 초대했어요!',
    },
    {
      'type': 'friend',
      'title': '👥 친구 추가 요청',
      'message': '지훈님이 친구 요청을 보냈어요!',
    },
    {
      'type': 'challenge',
      'title': '🏃 챌린지 초대',
      'message': '건우님이 7일 챌린지에 초대했어요!',
    },
    {
      'type': 'friend',
      'title': '👥 친구 추가 요청',
      'message': '예린님이 친구 요청을 보냈어요!',
    },
    {
      'type': 'challenge',
      'title': '🏃‍♂️ 챌린지 초대',
      'message': '정민님이 3일 챌린지에 초대했어요!',
    },
    {
      'type': 'friend',
      'title': '👥 친구 추가 요청',
      'message': '하늘님이 친구 요청을 보냈어요!',
    },
    {
      'type': 'friend',
      'title': '👥 친구 추가 요청',
      'message': '민서님이 친구 요청을 보냈어요!',
    },
    {
      'type': 'challenge',
      'title': '🏃‍♂️ 챌린지 초대',
      'message': '재민님이 3일 챌린지에 초대했어요!',
    },
    {
      'type': 'friend',
      'title': '👥 친구 추가 요청',
      'message': '종민님이 친구 요청을 보냈어요!',
    },
    {
      'type': 'challenge',
      'title': '🏃‍♂️ 챌린지 초대',
      'message': '하영님이 3일 챌린지에 초대했어요!',
    },
  ];

  void _handleAccept(int index) {
    final type = notifications[index]['type'];

    if (type == 'challenge') {
      Navigator.pushNamed(context, '/invite');
    } else if (type == 'friend') {
      Navigator.pushNamed(context, '/friends');
    }

    setState(() {
      notifications.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFF9FAEB),
        foregroundColor: const Color(0xFF021F59),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          '수신함',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF021F59),
          ),
        ),
      ),
      backgroundColor: const Color(0xFFF9FAEB),
      body: notifications.isEmpty
          ? const Center(child: Text("알림이 없습니다"))
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: notifications.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final item = notifications[index];

                return Dismissible(
                  key: ValueKey(item['message']),
                  direction: DismissDirection.endToStart,
                  onDismissed: (_) {
                    setState(() {
                      notifications.removeAt(index);
                    });
                  },
                  background: Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                    color: Colors.red[300],
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 내용 영역
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['title'],
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                item['message'],
                                style: const TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                        ),

                        // 수락/거절 버튼
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () => _handleAccept(index),
                              icon: const Icon(
                                Icons.check,
                                color: Color(0xFF021F59), //  Color(0xFFD0F252)너무 밝음
                                size: 24,
                              ),
                              tooltip: '수락',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
