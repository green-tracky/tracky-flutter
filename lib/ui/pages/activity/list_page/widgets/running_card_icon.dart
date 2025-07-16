import 'package:flutter/material.dart';

class RunningCardIcon extends StatelessWidget {
  const RunningCardIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.black54,
      ),
      child: Transform(
        alignment: Alignment.center,
        transform: Matrix4.identity()..scale(-1.0, 1.0),
        child: const Icon(
          Icons.directions_run,
          size: 32,
          color: Colors.white,
        ),
      ),
    );
  }
}
