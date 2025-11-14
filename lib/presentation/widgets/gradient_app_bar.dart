import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class MyGradientAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final EdgeInsets? padding;

  const MyGradientAppBar({
    super.key,
    required this.title,
    this.actions,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Padding(
        padding: padding ?? EdgeInsets.zero,
        child: Text(
          title,
          style: const TextStyle(fontSize: 20),
        ),
      ),
      centerTitle: false,
      actions: actions,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.blue, AppColors.green],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
