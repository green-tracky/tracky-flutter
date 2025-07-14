import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoWidget extends StatefulWidget {
  const VideoWidget({super.key});

  @override
  State<VideoWidget> createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  late VideoPlayerController _controller;
  bool _isVideoEnded = false;
  bool _isVideoStarted = false; // 사용자가 버튼을 눌렀는지 여부

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/videos/running.mp4')
      ..initialize().then((_) {
        if (mounted) {
          setState(() {}); // 영상 초기화 후 UI 갱신
        }

        // 영상이 끝났는지 감지
        _controller.addListener(() {
          if (_controller.value.position >= _controller.value.duration &&
              !_controller.value.isPlaying) {
            setState(() {
              _isVideoEnded = true;
            });
          }
        });
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _startVideo() {
    _controller.play();
    setState(() {
      _isVideoStarted = true;
      _isVideoEnded = false;
    });
  }

  void _replayVideo() {
    _controller.seekTo(Duration.zero);
    _controller.play();
    setState(() {
      _isVideoEnded = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _controller.value.isInitialized
        ? Stack(
      alignment: Alignment.center,
      children: [
        AspectRatio(
          aspectRatio: _controller.value.aspectRatio,

          child: VideoPlayer(_controller),
        ),
        if (!_isVideoStarted || _isVideoEnded)
          IconButton(
            iconSize: 60,
            icon: Icon(Icons.play_arrow, color: Colors.white),
            onPressed:
            _isVideoEnded ? _replayVideo : _startVideo,
          ),
      ],
    )
        : Center(child: CircularProgressIndicator());
  }
}