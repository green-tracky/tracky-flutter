import 'package:flutter/material.dart';
import 'package:tracky_flutter/_core/constants/theme.dart';

class EditableTitle extends StatefulWidget {
  final String initialTitle;
  final Function(String) onSubmit;

  const EditableTitle({
    super.key,
    required this.initialTitle,
    required this.onSubmit,
  });

  @override
  State<EditableTitle> createState() => _EditableTitleState();
}

class _EditableTitleState extends State<EditableTitle> {
  late TextEditingController _titleController;
  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.initialTitle);
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: isEditing
          ? TextField(
        controller: _titleController,
        autofocus: true,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: AppColors.trackyIndigo,
        ),
        onSubmitted: (newTitle) async {
          await widget.onSubmit(newTitle.trim());
          setState(() => isEditing = false);
        },
        decoration: const InputDecoration(
          isDense: true,
          border: UnderlineInputBorder(),
        ),
      )
          : GestureDetector(
        onTap: () => setState(() => isEditing = true),
        behavior: HitTestBehavior.translucent,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Text(
            _titleController.text,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.trackyIndigo,
            ),
          ),
        ),
      ),
    );
  }
}
