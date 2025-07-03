import 'package:flutter/material.dart';

class RecectToAll extends StatelessWidget {
  const RecectToAll({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 8.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "최근 활동",
            style: TextStyle(
              fontSize: 18,
              color: Colors.black38,
              fontWeight: FontWeight.bold,
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Text(
              "전체보기 >",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
