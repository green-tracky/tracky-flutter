import 'package:flutter/material.dart';

enum MenuEntry {
  about('About'),
  showMessage('Show Message'),
  hideMessage('Hide Message'),
  colorRed('Red Background'),
  colorGreen('Green Background'),
  colorBlue('Blue Background');

  const MenuEntry(this.label);

  final String label;
}

class SimpleMenu extends StatefulWidget {
  const SimpleMenu({super.key});

  @override
  State<SimpleMenu> createState() => _SimpleMenuState();
}

class _SimpleMenuState extends State<SimpleMenu> {
  MenuEntry? _lastSelection;
  final FocusNode _buttonFocusNode = FocusNode(debugLabel: 'Menu Button');

  @override
  void dispose() {
    _buttonFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // 1) 메뉴 앵커 + 트리거 버튼
          MenuAnchor(
            childFocusNode: _buttonFocusNode,
            menuChildren: [
              MenuItemButton(
                onPressed: () => _activate(MenuEntry.about),
                child: Text(MenuEntry.about.label),
              ),
              MenuItemButton(
                onPressed: () => _activate(MenuEntry.showMessage),
                child: Text(MenuEntry.showMessage.label),
              ),
              MenuItemButton(
                onPressed: () => _activate(MenuEntry.hideMessage),
                child: Text(MenuEntry.hideMessage.label),
              ),
            ],
            builder: (context, controller, child) {
              return TextButton(
                focusNode: _buttonFocusNode,
                onPressed: () =>
                    controller.isOpen ? controller.close() : controller.open(),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      _lastSelection != null
                          ? '${_lastSelection!.label}'
                          : '날짜선택',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SizedBox(width: 4), // 텍스트와 아이콘 간 여백
                    Icon(
                      Icons.arrow_drop_down,
                      size: 28,
                    ),
                  ],
                ),
              );
            },
          ),
          // 2) 선택 결과 표시
          const SizedBox(height: 14),

        ],
      ),
    );
  }

  /// 메뉴 항목을 눌렀을 때 **오직 선택만 기록**.
  void _activate(MenuEntry entry) {
    setState(() {
      _lastSelection = entry;
    });
  }
}
