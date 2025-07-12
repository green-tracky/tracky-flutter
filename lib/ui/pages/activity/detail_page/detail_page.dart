import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:tracky_flutter/data/model/activity.dart';
import 'package:tracky_flutter/ui/pages/activity/activity_vm.dart';
import 'package:tracky_flutter/ui/pages/activity/detail_page/intensity/intensity_page.dart';
import 'package:tracky_flutter/ui/pages/activity/detail_page/memo_page/memo_page.dart';
import 'package:tracky_flutter/ui/pages/activity/detail_page/road_menu/place_sheet_page.dart';
import 'package:tracky_flutter/ui/pages/activity/detail_page/runsegment_detail_page/segment_detail_page.dart';
import 'package:tracky_flutter/ui/pages/run/main_page/main_page.dart';

import 'map_view/map_view_page.dart';

class RunDetailPage extends ConsumerStatefulWidget {
  @override
  ConsumerState<RunDetailPage> createState() => _RunDetailPageState();
}

class _RunDetailPageState extends ConsumerState<RunDetailPage> {
  bool isEditingTitle = false;
  late TextEditingController _titleController;

  @override
  void initState() {
    super.initState();

    final result = ref.read(runResultProvider);
    _titleController = TextEditingController(
      text: getDefaultTitle(result?.startTime),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  String getDefaultTitle(DateTime? time) {
    if (time == null) return "";
    final weekdays = ['월요일', '화요일', '수요일', '목요일', '금요일', '토요일', '일요일'];
    final hour = time.hour;
    final ampm = hour < 12 ? '오전' : '오후';
    final weekday = weekdays[time.weekday - 1];
    return '$weekday $ampm 러닝';
  }

  String getFormattedDate(DateTime? time) {
    if (time == null) return "";
    return DateFormat('yyyy. MM. dd. - HH:mm').format(time);
  }

  @override
  Widget build(BuildContext context) {
    final result = ref.watch(runResultProvider);

    if (result == null) {
      return Scaffold(
        body: Center(
          child: Text("러닝 기록이 없습니다"),
        ),
      );
    }

    final selectedSurface = ref.watch(runningSurfaceProvider);

    return Scaffold(
      backgroundColor: Color(0xFFF9FAEB),
      appBar: AppBar(
        backgroundColor: Color(0xFFF9FAEB),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            //  runResultProvider 초기화 (선택 사항)
            ref.read(runResultProvider.notifier).state = null;

            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => RunMainPage()),
              (route) => false,
            );
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.more_horiz, color: Colors.black),
            onPressed: () {
              showCupertinoModalPopup(
                context: context,
                builder: (_) => CupertinoActionSheet(
                  title: Text("러닝 기록"),
                  actions: [
                    CupertinoActionSheetAction(
                      onPressed: () {
                        Navigator.pop(context);
                        // TODO: 삭제 처리
                        print("삭제됨");
                      },
                      isDestructiveAction: true,
                      child: Text("삭제"),
                    ),
                  ],
                  cancelButton: CupertinoActionSheetAction(
                    onPressed: () => Navigator.pop(context),
                    child: Text("취소"),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              getFormattedDate(result.startTime),
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(height: 4),
            InkWell(
              onTap: () {
                setState(() => isEditingTitle = true);
              },
              child: Row(
                children: [
                  Expanded(
                    child: isEditingTitle
                        ? TextField(
                            controller: _titleController,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            onSubmitted: (_) {
                              setState(() => isEditingTitle = false);
                            },
                          )
                        : Text(
                            _titleController.text,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                  Icon(isEditingTitle ? Icons.check : Icons.edit, size: 20),
                ],
              ),
            ),
            Divider(color: Colors.grey),
            SizedBox(height: 10),

            // 거리 요약
            Text(
              result.distance.toStringAsFixed(2),
              style: TextStyle(
                fontSize: 70,
                fontWeight: FontWeight.w900,
                color: Colors.black,
              ),
            ),
            Text("킬로미터", style: TextStyle(color: Colors.grey, fontSize: 18)),

            SizedBox(height: 28),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _InfoItem(label: '평균 페이스', value: result.averagePace),
                SizedBox(width: 32),
                _InfoItem(label: '시간', value: result.time),
                SizedBox(width: 32),
                _InfoItem(label: '칼로리', value: '${result.calories}'),
              ],
            ),

            SizedBox(height: 32),

            // 지도
            SizedBox(
              height: 350,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: MapView(paths: result.paths),
              ),
            ),

            SizedBox(height: 24),

            Text(
              "구간",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            SizedBox(height: 24),
            Row(
              children: [
                Text("Km", style: TextStyle(color: Colors.grey, fontSize: 16)),
                SizedBox(width: 48),
                Text(
                  "평균 페이스",
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
              ],
            ),
            SizedBox(height: 24),
            Row(
              children: [
                Text(
                  result.distance.toStringAsFixed(2),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                SizedBox(width: 34),
                Text(
                  result.averagePace,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ],
            ),

            SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => RunSegmentDetailPage(
                        startTime: result.startTime,
                        endTime: result.endTime,
                        distance: result.distance,
                        averagePace: result.averagePace,
                        bestPace: "10'41''", // TODO: 실제 값으로
                        runDuration: result.time,
                        totalDuration: result.time,
                        calories: result.calories,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFD0F252),
                  foregroundColor: Color(0xFF021F59),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 20),
                ),
                child: Text("상세 정보", style: TextStyle(fontSize: 16)),
              ),
            ),

            SizedBox(height: 24),

            _DividedExpandableTile(
              title: "러닝 강도",
              trailing: (() {
                final intensity = ref.watch(runIntensityProvider);
                return intensity == null
                    ? Icon(Icons.add)
                    : Text(
                        "$intensity/10",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      );
              })(),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const IntensityPage()),
                );
              },
            ),

            _DividedExpandableTile(
              title: "러닝 장소",
              trailing: selectedSurface == null
                  ? Icon(Icons.add)
                  : Icon(
                      getSurfaceIcon(selectedSurface),
                      color: Color(0xFF021F59),
                    ),
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  backgroundColor: Color(0xFFF9FAEB),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(24),
                    ),
                  ),
                  builder: (_) => SurfaceSelectSheet(
                    onSelect: (s) {
                      ref.read(runningSurfaceProvider.notifier).state = s;
                      Navigator.pop(context);
                    },
                  ),
                );
              },
            ),

            _ExpandableTileWithoutDivider(
              title: "메모",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => MemoPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoItem extends StatelessWidget {
  final String label;
  final String value;

  const _InfoItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
        ),
        SizedBox(height: 4),
        Text(label, style: TextStyle(color: Colors.grey, fontSize: 16)),
      ],
    );
  }
}

class _DividedExpandableTile extends StatelessWidget {
  final String title;
  final Widget? trailing;
  final VoidCallback? onTap;

  const _DividedExpandableTile({
    required this.title,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 10),
          title: Text(title, style: TextStyle(fontWeight: FontWeight.w600)),
          trailing: trailing ?? Icon(Icons.add),
          onTap: onTap,
        ),
        Divider(color: Colors.grey[400]),
      ],
    );
  }
}

class _ExpandableTileWithoutDivider extends ConsumerWidget {
  final String title;
  final VoidCallback? onTap;

  const _ExpandableTileWithoutDivider({
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final memo = ref.watch(runMemoProvider);

    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 10),
      title: Text(title, style: TextStyle(fontWeight: FontWeight.w600)),
      subtitle: memo.trim().isNotEmpty
          ? Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Text(
                memo,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 14, color: Colors.black),
              ),
            )
          : null,
      trailing: memo.trim().isNotEmpty
          ? Icon(Icons.note_alt_outlined, color: Colors.black)
          : Icon(Icons.add),
      onTap: onTap,
    );
  }
}
