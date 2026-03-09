import 'package:cga_app/app/core/ui/styles/app_colors.dart';
import 'package:cga_app/app/core/util/screen_util.dart';
import 'package:flutter/material.dart';

class HomeMenuButton extends StatefulWidget {
  final String title;
  final IconData icon;
  final VoidCallback? onTap;

  const HomeMenuButton({
    super.key,
    required this.title,
    required this.icon,
    this.onTap,
  });

  @override
  State<HomeMenuButton> createState() => _HomeMenuButtonState();
}

class _HomeMenuButtonState extends State<HomeMenuButton> {
  bool isHovering = false;

  @override
  Widget build(BuildContext context) {
    final isMobile = ScreenUtils.isMobile(context);

    final double iconContainerSize = isMobile ? 48 : 48;
    final double iconSize = isMobile ? 24 : 32;
    final double fontSize = isMobile ? 14 : 18;
    final double verticalPadding = isMobile ? 20 : 32;

    return MouseRegion(
      onEnter: isMobile ? null : (_) => setState(() => isHovering = true),
      onExit: isMobile ? null : (_) => setState(() => isHovering = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: isHovering
                  ? AppColors.menuButtonShadow015
                  : AppColors.menuButtonShadow005,
              blurRadius: isHovering ? 20 : 10,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: widget.onTap,
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: verticalPadding,
              horizontal: 16,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: iconContainerSize,
                  width: iconContainerSize,
                  decoration: BoxDecoration(
                    color: Theme.of(context)
                        .primaryColor
                        .withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    widget.icon,
                    size: iconSize,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                SizedBox(height: isMobile ? 12 : 20),
                Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: fontSize,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}