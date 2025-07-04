import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BadgeDetailPage extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String date;
  final String? imageAsset;
  final Color? badgeColor;
  final bool isMine;
  final bool isAchieved;

  const BadgeDetailPage({
    super.key,
    required this.title,
    this.subtitle,
    required this.date,
    this.imageAsset,
    this.badgeColor,
    required this.isMine,
    required this.isAchieved,
  });

  @override
  Widget build(BuildContext context) {
    final backgroundColor = badgeColor ?? Colors.black;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: SafeArea(
          child: Stack(
            children: [
              // 중앙 콘텐츠
              Center(
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (imageAsset != null)
                        Container(
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 2,
                              color: !isAchieved ? Colors.white : Colors.black,
                            ),
                          ),
                          clipBehavior: Clip.hardEdge,
                          child: ClipOval(
                            child: Transform.scale(
                              scale: 2,
                              child: Image.asset(
                                imageAsset!,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),

                      const SizedBox(height: 40),

                      Text(
                        date,
                        style: TextStyle(
                          fontSize: 16,
                          color: !isAchieved ? Colors.white : Colors.black,
                        ),
                      ),

                      const SizedBox(height: 12),

                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: !isAchieved ? Colors.white : Colors.black,
                        ),
                      ),

                      const SizedBox(height: 12),

                      Text(
                        subtitle != null
                            ? subtitle!
                            : isAchieved
                            ? '메달을 획득했습니다!'
                            : '메달 설명',
                        style: TextStyle(
                          fontSize: 16,
                          color: !isAchieved ? Colors.white : Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // 좌측 상단 메뉴
              if (isMine && isAchieved)
                Positioned(
                  top: 12,
                  left: 12,
                  child: IconButton(
                    icon: const Icon(CupertinoIcons.ellipsis),
                    color: !isAchieved ? Colors.white : Colors.black,
                    onPressed: () {
                      showCupertinoModalPopup(
                        context: context,
                        builder: (_) => CupertinoActionSheet(
                          actions: [
                            CupertinoActionSheetAction(
                              onPressed: () {
                                Navigator.pop(context);
                                debugPrint("러닝 이동");
                              },
                              child: const Text("러닝 이동", style: TextStyle(color: Colors.blue),),
                            ),
                          ],
                          cancelButton: CupertinoActionSheetAction(
                            onPressed: () => Navigator.pop(context),
                            child: const Text("취소", style: TextStyle(color: Colors.blue),),
                          ),
                        ),
                      );
                    },
                  ),
                ),

              // 우측 상단 닫기 버튼
              Positioned(
                top: 12,
                right: 12,
                child: IconButton(
                  icon: const Icon(Icons.close_rounded),
                  color: !isAchieved ? Colors.white : Colors.black,
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
