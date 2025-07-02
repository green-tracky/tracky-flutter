import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:tracky_flutter/data/model/activity.dart';
import 'package:tracky_flutter/ui/pages/activity/activity_vm.dart';
import 'package:tracky_flutter/ui/pages/activity/detail_page/intensity_page.dart';
import 'package:tracky_flutter/ui/pages/activity/detail_page/memo_page.dart';
import 'package:tracky_flutter/ui/pages/activity/detail_page/place_sheet_page.dart';
import 'package:tracky_flutter/ui/pages/activity/detail_page/segment_detail_page.dart';

import 'map_view_page.dart';

class RunDetailPage extends ConsumerStatefulWidget {
  final DateTime runDateTime;
  final double distance;
  final String avgPace;
  final String time;
  final int calories;

  RunDetailPage({
    required this.runDateTime,
    required this.distance,
    required this.avgPace,
    required this.time,
    required this.calories,
  });

  @override
  ConsumerState<RunDetailPage> createState() => _RunDetailPageState();
}

class _RunDetailPageState extends ConsumerState<RunDetailPage> {
  bool isEditingTitle = false;
  late TextEditingController _titleController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: getDefaultTitle());
  }

  String getDefaultTitle() {
    final weekdays = ['월요일', '화요일', '수요일', '목요일', '금요일', '토요일', '일요일'];
    final hour = widget.runDateTime.hour;
    final ampm = hour < 12 ? '오전' : '오후';
    final weekday = weekdays[widget.runDateTime.weekday - 1];
    return '$weekday $ampm 러닝';
  }

  String getFormattedDate() {
    return DateFormat('yyyy. MM. dd. - HH:mm').format(widget.runDateTime);
  }

  @override
  Widget build(BuildContext context) {
    final selectedSurface = ref.watch(runningSurfaceProvider);
    return Scaffold(
      backgroundColor: Color(0xFFF9FAEB),
      appBar: AppBar(
        backgroundColor: Color(0xFFF9FAEB),
        elevation: 0,
        leading: BackButton(color: Colors.black),
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
            Text(getFormattedDate(), style: TextStyle(color: Colors.grey)),
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
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            onSubmitted: (_) {
                              setState(() => isEditingTitle = false);
                            },
                          )
                        : Text(
                            _titleController.text,
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                  ),
                  Icon(
                    isEditingTitle ? Icons.check : Icons.edit,
                    size: 20,
                  ),
                ],
              ),
            ),
            Divider(color: Colors.grey),
            SizedBox(height: 10),

            /// 숫자 요약
            Text(
              widget.distance.toStringAsFixed(2),
              style: TextStyle(fontSize: 70, fontWeight: FontWeight.w900, color: Colors.black),
            ),
            Text("킬로미터", style: TextStyle(color: Colors.grey, fontSize: 18)),

            SizedBox(height: 28),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _InfoItem(label: '평균 페이스', value: widget.avgPace),
                SizedBox(width: 32),
                _InfoItem(label: '시간', value: widget.time),
                SizedBox(width: 32),
                _InfoItem(label: '칼로리', value: '${widget.calories}'),
              ],
            ),

            SizedBox(height: 32),

            // 지도
            SizedBox(
              height: 350,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: MapView(
                  paths: [
                    [
                      LatLng(35.1555, 129.0590),
                      LatLng(35.1560, 129.0595),
                      LatLng(35.1565, 129.0600),
                    ],
                    [
                      LatLng(35.1530, 129.0350),
                      LatLng(35.1535, 129.0355),
                    ],
                  ],
                ),
              ),
            ),

            SizedBox(height: 24),

            Text("구간", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Km", style: TextStyle(color: Colors.grey, fontSize: 16)),
                SizedBox(width: 48),
                Text("평균 페이스", style: TextStyle(color: Colors.grey, fontSize: 16)),
              ],
            ),

            SizedBox(height: 24),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "0.25",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                SizedBox(width: 34),
                Text(widget.avgPace, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
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
                      builder: (context) => RunSegmentDetailPage(
                        startTime: DateTime(2025, 6, 17, 8, 55),
                        endTime: DateTime(2025, 6, 17, 8, 58),
                        distance: 0.15,
                        averagePace: "14'11''",
                        bestPace: "10'41''",
                        runDuration: "02:12",
                        totalDuration: "02:44",
                        calories: 6,
                        // startTime: run.startTime,
                        // endTime: run.endTime,
                        // distance: run.distance,
                        // averagePace: run.averagePace,
                        // bestPace: run.bestPace,
                        // runDuration: run.runningTime,
                        // totalDuration: run.elapsedTime,
                        // calories: run.calories,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFD0F252),
                  foregroundColor: Color(0xFF021F59),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                  padding: EdgeInsets.symmetric(vertical: 20),
                ),
                child: Text("상세 정보", style: TextStyle(fontSize: 16)),
              ),
            ),

            SizedBox(height: 24),

            _DividedExpandableTile(
              title: "러닝 강도",
              trailing: ref.watch(runIntensityProvider) == null
                  ? Icon(Icons.add)
                  : Text(
                      "${ref.watch(runIntensityProvider)!}/10",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                    ),
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
                  : Icon(getSurfaceIcon(selectedSurface), color: Color(0xFF021F59)),
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  backgroundColor: Color(0xFFF9FAEB),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
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
        Text(value, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28)),
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
      trailing: memo.trim().isNotEmpty ? Icon(Icons.note_alt_outlined, color: Colors.black) : Icon(Icons.add),
      onTap: onTap,
    );
  }
}
