import 'package:flutter/material.dart';

class EndTimeSettingPage extends StatefulWidget {
  const EndTimeSettingPage({super.key});

  @override
  State<EndTimeSettingPage> createState() => _DateRangeSelectPageState();
}

class _DateRangeSelectPageState extends State<EndTimeSettingPage> {
  DateTime? startDate;
  DateTime? endDate;

  Future<void> _selectStartDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() => startDate = picked);
    }
  }

  Future<void> _selectEndDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: startDate ?? DateTime.now(),
      firstDate: startDate ?? DateTime(2023),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() => endDate = picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9FAEB),
      appBar: AppBar(
        title: Text("날짜 선택"),
        centerTitle: true,
        backgroundColor: Color(0xFFF9FAEB),
      ),
      body: Column(
        children: [
          ListTile(
            title: Text("시작 날짜"),
            subtitle: Text(
              startDate != null ? "${startDate!.year}년 ${startDate!.month}월 ${startDate!.day}일" : "선택",
            ),
            onTap: _selectStartDate,
          ),
          Divider(),
          ListTile(
            title: Text("종료 날짜"),
            subtitle: Text(
              endDate != null ? "${endDate!.year}년 ${endDate!.month}월 ${endDate!.day}일" : "선택",
            ),
            onTap: _selectEndDate,
          ),
          Spacer(),
          Padding(
            padding: EdgeInsets.all(24),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size.fromHeight(48),
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32),
                ),
              ),
              onPressed: () {
                if (startDate != null && endDate != null) {
                  Navigator.pop(
                    context,
                    "${startDate!.year}.${startDate!.month}.${startDate!.day} ~ "
                    "${endDate!.year}.${endDate!.month}.${endDate!.day}",
                  );
                }
              },
              child: Text(
                "저장",
                style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
