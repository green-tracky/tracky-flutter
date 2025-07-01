import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChallengeInvitePage extends StatelessWidget {
  final String challengeTitle = "이름 작성란";
  final String distance = "5.00km";
  final String period = "6월 17일 ~ 6월 18일";

  ChallengeInvitePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(color: Colors.white),
        centerTitle: true,
        title: const Text("Tracky", style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () => _showInviteOptions(context),
          ),
        ],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'images/challenge_invitation.png', // 실제 배경 이미지
            fit: BoxFit.cover,
          ),
          Container(
            color: Colors.black.withOpacity(0.3), // 어두운 오버레이
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(32, 100, 32, 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(), // 상단 여백
                Column(
                  children: [
                    Text(
                      challengeTitle,
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      distance,
                      style: const TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      period,
                      style: const TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.white,
                        side: const BorderSide(color: Colors.white),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context); // 거부
                      },
                      child: const Text("거절"),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: () {
                        // 수락 처리 TODO
                      },
                      child: const Text("수락"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showInviteOptions(BuildContext context) {
  showCupertinoModalPopup(
    context: context,
    builder: (BuildContext context) => CupertinoActionSheet(
      title: const Text("초대 옵션"),
      message: const Text("챌린지 초대에 대한 행동을 선택하세요."),
      actions: <Widget>[
        CupertinoActionSheetAction(
          onPressed: () {
            Navigator.pop(context);
            debugPrint("수락");
            // TODO: 수락 처리
          },
          child: const Text("수락", style: TextStyle(color: Colors.blue),),
        ),

        // ✅ Divider 추가
        Container(
          height: 1,
          color: Color(0xFFE0E0E0),
        ),

        CupertinoActionSheetAction(
          onPressed: () {
            Navigator.pop(context);
            debugPrint("거절");
            // TODO: 거절 처리
          },
          isDestructiveAction: true,
          child: const Text("거절"),
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        onPressed: () {
          Navigator.pop(context);
        },
        isDefaultAction: true,
        child: const Text("취소", style: TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.w100),),
      ),
    ),
  );
}

}
