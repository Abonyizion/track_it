import 'package:flutter/material.dart';
import 'package:track_it/core/constants/app_colors.dart';
import 'package:track_it/core/utils/date_formatter.dart';


class SummaryCard extends StatelessWidget {
  final String title;
  final double amount;
  final bool isVisible;
  final bool showIcon;          // only Total Balance shows icon
  final IconData? icon;
  final double? height;
  final bool centerText;
  final Color? bgColor;
  final Color? iconColor;
  final Color? iconBgColor;
  final VoidCallback? onToggleVisibility;

  const SummaryCard({
    super.key,
    required this.title,
    required this.amount,
    required this.isVisible,
    required this.showIcon,
    this.icon,
    this.height,
    this.centerText = false,
    this.bgColor,
    this.iconColor,
    this.iconBgColor,
    this.onToggleVisibility,
  });


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height ?? 95,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: bgColor ?? AppColors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: centerText
            ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                  fontSize: 10,
                      color: AppColors.textDark),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  width: 7,
                ),
                // Visibility toggle icon
                if (showIcon)
                  InkWell(
                    onTap: onToggleVisibility,
                    child: Icon(
                      isVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      size: 18,
                      color: AppColors.black
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 6),
            Flexible(
              child: Text(isVisible
                  ? DateFormatter.formatCurrency(amount)
                  : "****",
                    style: TextStyle(
                        fontSize: 20 ,
                      fontWeight: FontWeight.w900,
                      color: AppColors.textDark
                     ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
            ),
          ],
        )
            : Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

              const SizedBox(
                  width: 12),
            Flexible( // prevents overflow
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null) Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      height: 30,
                      width: 40,
                     // padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: iconBgColor,
                        shape: BoxShape.circle
                      ),
                      child: Icon(icon,
                          size: 20,
                          color: iconColor),
                    ),
                  ),
                  if (icon != null)
                    Text(
                      title,
                    style: const TextStyle(
                    fontSize: 10,
                        color: AppColors.textDark),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Flexible(
                    child: Text(  isVisible
                        ? DateFormatter.formatCurrency(amount)
                        : "****",
                        style: const TextStyle(
                            fontSize: 18,
                          color: AppColors.textDark,
                            fontWeight: FontWeight.w900,
                            ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
