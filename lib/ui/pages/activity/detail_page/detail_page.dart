import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RunDetailPage extends StatefulWidget {
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
  State<RunDetailPage> createState() => _RunDetailPageState();
}

class _RunDetailPageState extends State<RunDetailPage> {
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
    return Scaffold(
      backgroundColor: Color(0xFFF9FAEB),
      appBar: AppBar(
        backgroundColor: Color(0xFFF9FAEB),
        elevation: 0,
        leading: BackButton(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(getFormattedDate(), style: TextStyle(color: Colors.grey)),
            SizedBox(height: 4),
            Row(
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
                IconButton(
                  icon: Icon(isEditingTitle ? Icons.check : Icons.edit, size: 20),
                  onPressed: () {
                    setState(() => isEditingTitle = !isEditingTitle);
                  },
                ),
              ],
            ),
            Divider(color: Colors.grey),
            SizedBox(height: 10),

            /// 숫자 요약 (왼쪽 정렬)
            Text(
              widget.distance.toStringAsFixed(2),
              style: TextStyle(fontSize: 70, fontWeight: FontWeight.w900, color: Colors.black),
            ),
            Text("킬로미터", style: TextStyle(color: Colors.grey, fontSize: 18)),

            SizedBox(height: 28),
            Row(
              mainAxisAlignment: MainAxisAlignment.start, // 왼쪽으로 붙이기
              children: [
                _InfoItem(label: '평균 페이스', value: widget.avgPace),
                SizedBox(width: 32),
                _InfoItem(label: '시간', value: widget.time),
                SizedBox(width: 32),
                _InfoItem(label: '칼로리', value: '${widget.calories}'),
              ],
            ),

            SizedBox(height: 32),

            Container(
              height: 350,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Text("지도 영역", style: TextStyle(color: Colors.black)),
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
                onPressed: () {},
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

            _DividedExpandableTile(title: "러닝 강도"),
            _DividedExpandableTile(title: "러닝 장소"),
            _ExpandableTileWithoutDivider(title: "메모"),
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

  const _DividedExpandableTile({required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 10),
          title: Text(title, style: TextStyle(fontWeight: FontWeight.w600)),
          trailing: Icon(Icons.add),
          onTap: () {},
        ),
        Divider(color: Colors.grey[400]),
      ],
    );
  }
}

class _ExpandableTileWithoutDivider extends StatelessWidget {
  final String title;

  const _ExpandableTileWithoutDivider({required this.title});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 10),
      title: Text(title, style: TextStyle(fontWeight: FontWeight.w600)),
      trailing: Icon(Icons.add),
      onTap: () {},
    );
  }
}
