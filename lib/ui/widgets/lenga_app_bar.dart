import 'package:flutter/material.dart';

class LengaAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final bool showLogo;
  final Widget? bottom;
  final double bottomHeight;

  const LengaAppBar({
    super.key,
    required this.title,
    this.actions,
    this.showLogo = false,
    this.bottom,
    this.bottomHeight = 0,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showLogo) ...[
            const Icon(Icons.school, color: Colors.blue, size: 24),
            const SizedBox(width: 8),
          ],
          Text(
            title,
            style: showLogo
                ? const TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  )
                : null,
          ),
        ],
      ),
      actions: actions,
      bottom: bottom != null
          ? PreferredSize(
              preferredSize: Size.fromHeight(bottomHeight),
              child: bottom!,
            )
          : null,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + bottomHeight);
}
