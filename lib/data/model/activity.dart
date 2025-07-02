import 'package:flutter/material.dart';

enum RunningSurface { road, track, trail }

String getSurfaceLabel(RunningSurface surface) {
  switch (surface) {
    case RunningSurface.road:
      return '도로';
    case RunningSurface.track:
      return '트랙';
    case RunningSurface.trail:
      return '산길';
  }
}

IconData getSurfaceIcon(RunningSurface surface) {
  switch (surface) {
    case RunningSurface.road:
      return Icons.add_road;
    case RunningSurface.track:
      return Icons.directions_run;
    case RunningSurface.trail:
      return Icons.terrain;
  }
}
