import 'package:flutter/material.dart';
import 'package:flutter_riverpod_best_practices/core/constants/app_sizes.dart';

import '../../constants/app_colors.dart';
import 'custom_icon.dart';

class DialogContainer extends StatelessWidget {
  final String title;
  final Widget content;
  final double minHeight;
  final double maxHeight;
  final Color? background;
  final Function()? onDismiss;

  const DialogContainer(
      this.title, this.minHeight, this.maxHeight, this.content,
      {super.key, this.background = Colors.white, this.onDismiss});

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: SafeArea(
        child: Container(
          constraints:
              BoxConstraints(minHeight: minHeight, maxHeight: maxHeight),
          width: double.maxFinite,
          margin: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom > 0
                  ? (MediaQuery.of(context).viewInsets.bottom + 20)
                  : 20,
              left: 8,
              right: 8),
          padding:
              const EdgeInsets.only(left: 12, right: 12, top: 8, bottom: 16),
          decoration: BoxDecoration(
            color: background,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 8,
              ),
              Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                      width: 30,
                      child: Divider(
                        height: 2,
                        color: Colors.grey.shade700,
                      ))),

              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                  SizedBox(
                    height: 32,
                    width: 32,
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      iconSize: 24,
                      onPressed: () {
                        if (onDismiss != null) {
                          onDismiss!();
                        } else {
                          Navigator.of(context).pop();
                        }
                      },
                      icon: const CustomIcon(
                        icon: Icons.close_rounded,
                      ),
                      color: AppColors.primaryColor,
                      style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all(
                              AppColors.primaryColor.withAlpha((0.15*255).toInt()))),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              //Expanded(child: content),
              Flexible(child: content), //can be expanded
              //content,
              kGapM,
            ],
          ),
        ),
      ),
    );
  }
}