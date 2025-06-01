import 'package:flutter/material.dart';
import 'package:flutter_riverpod_best_practices/core/constants/app_colors.dart';
import 'package:flutter_riverpod_best_practices/core/constants/app_text_styles.dart';

class AppBarDefault extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Function()? onBackPressed;
  const AppBarDefault({super.key, required this.title, this.onBackPressed});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      surfaceTintColor: AppColors.white,
      backgroundColor: AppColors.white,
      leadingWidth: onBackPressed != null ? 56 : 16,
      titleSpacing: 0,
      leading:
          onBackPressed != null
              ? Icon(
                Icons.arrow_back_outlined,
                size: 24,
                color: AppColors.black,
              )
              : SizedBox(),
      title: Padding(
        padding: const EdgeInsets.only(left: 0),
        child: Text(title, style: AppTextStyles.appBarTitleTS,),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
