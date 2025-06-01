import 'package:flutter/material.dart';
import 'package:flutter_riverpod_best_practices/core/constants/app_colors.dart';
import 'package:flutter_riverpod_best_practices/core/constants/app_text_styles.dart';

class ButtonDefault extends StatelessWidget {
  final String title;
  final Function()? onPressed;
  final double? height;
  final double? width;
  const ButtonDefault({
    super.key,
    required this.title,
    this.onPressed,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      minWidth: width,
      height: height,
      disabledColor: AppColors.primaryColor.withAlpha(127),
      color: AppColors.primaryColor,
      padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      child: Text(title, style: AppTextStyles.btnTS),
    );
  }

  factory ButtonDefault.expanded({
    required String title,
    final Function()? onPressed,
  }) {
    return ButtonDefault(
      title: title,
      onPressed: onPressed,
      width: double.infinity,
    );
  }
}
