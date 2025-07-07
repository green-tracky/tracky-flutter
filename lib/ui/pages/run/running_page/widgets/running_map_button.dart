import 'package:flutter/material.dart';
import 'package:tracky_flutter/ui/pages/run/running_page/widgets/running_full_map.dart';

class SectionActionButton extends StatelessWidget {
  const SectionActionButton({super.key});

  void _openFullMap(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => FullMapPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 50,
      left: 30,
      child: InkWell(
        onTap: () => _openFullMap(context),
        borderRadius: BorderRadius.circular(40),
        child: Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: Colors.black,
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.map, color: Colors.white, size: 30),
        ),
      ),
    );
  }
}
