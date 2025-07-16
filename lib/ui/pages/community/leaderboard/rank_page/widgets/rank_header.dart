import 'package:flutter/material.dart';
import 'package:tracky_flutter/_core/constants/theme.dart';

class RankHeader extends StatelessWidget {
  final String selected;
  final VoidCallback onTapFilter;

  const RankHeader(this.selected, this.onTapFilter, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            selected,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: AppColors.trackyIndigo,
            ),
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTapFilter,
              borderRadius: BorderRadius.circular(20),
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.settings,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
