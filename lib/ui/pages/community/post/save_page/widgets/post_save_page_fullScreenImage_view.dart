import 'package:flutter/material.dart';

class FullScreenImageViewer extends StatefulWidget {
  final List images;
  final int startIndex;
  final bool isWeb;
  final Function(int) onDelete;

  const FullScreenImageViewer({
    super.key,
    required this.images,
    required this.startIndex,
    required this.isWeb,
    required this.onDelete,
  });

  @override
  State<FullScreenImageViewer> createState() => _FullScreenImageViewerState();
}

class _FullScreenImageViewerState extends State<FullScreenImageViewer> {
  late PageController _controller;
  late int currentIndex;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.startIndex;
    _controller = PageController(initialPage: currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              widget.onDelete(currentIndex);
            },
          ),
        ],
      ),
      body: PageView.builder(
        controller: _controller,
        itemCount: widget.images.length,
        onPageChanged: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        itemBuilder: (context, index) {
          return Center(
            child: widget.isWeb ? Image.memory(widget.images[index]) : Image.file(widget.images[index]),
          );
        },
      ),
    );
  }
}
