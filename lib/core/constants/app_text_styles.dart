import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod_best_practices/core/constants/app_colors.dart';

class AppTextStyles {
  static const TextStyle appBarTitleTS = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 24,
    color: AppColors.textColor,
    height: 36,
    letterSpacing: 0,
  );
  static const TextStyle shortInfoTS = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 10,
    color: AppColors.textColor,
    letterSpacing: 0,
  );
  static const TextStyle subTitleTS = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 16,
    color: AppColors.textSecondary,
    letterSpacing: 0,
  );
  static const TextStyle hintTS = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 16,
    color: AppColors.hintColor,
    letterSpacing: 0,
  );
  static const TextStyle btnTS = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 18,
    color: AppColors.white,
    letterSpacing: 0,
  );
  static const TextStyle labelTS = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 16,
    color: AppColors.labelColor,
    letterSpacing: 0,
  );
  static const TextStyle infoTS = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textInfo,
  );
  static const TextStyle headlineTS = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w500,
    color: AppColors.textColor,
  );

  static const TextStyle menuTS = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    color: AppColors.black,
  );
}
