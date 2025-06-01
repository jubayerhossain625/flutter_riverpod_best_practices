import 'package:flutter/material.dart';
import 'package:flutter_riverpod_best_practices/core/constants/app_colors.dart';
import 'package:flutter_riverpod_best_practices/core/constants/app_sizes.dart';
import 'package:flutter_riverpod_best_practices/core/constants/app_text_styles.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SearchWidget extends HookConsumerWidget {
  final Function() onMenuChanged;
  const SearchWidget({super.key, required this.onMenuChanged});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: AppColors.border),
              borderRadius: BorderRadius.circular(32),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 14, 16, 14),
                  child: Icon(Icons.search, color: AppColors.black),
                ),

                Expanded(
                  child: TextField(
                    style: AppTextStyles.hintTS.copyWith(
                      color: AppColors.black,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      hintText: "Find your service here (Ex: AC, Fridge etc)",
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 12,
                        color: AppColors.activeIconColor,
                      ),
                    ),
                  ),
                ),
                // Text(
                //   "Find your service here (Ex: AC, Fridge etc)",
                //   style: TextStyle(
                //     fontWeight: FontWeight.w300,
                //     fontSize: 10,
                //     color: AppColors.activeIconColor,
                //   ),
                // ),
              ],
            ),
          ),
        ),
        kGapL,
        GestureDetector(
          onTap: (){
            onMenuChanged();
          },
          child: Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(width: 1, color: AppColors.border),
            ),
            child: Icon(Icons.menu, color: AppColors.activeIconColor),
          ),
        ),
      ],
    );
  }
}
