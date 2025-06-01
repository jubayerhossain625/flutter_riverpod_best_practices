import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svprogresshud/flutter_svprogresshud.dart';
import 'package:flutter_riverpod_best_practices/core/common/widgets/appbar_default.dart';
import 'package:flutter_riverpod_best_practices/core/common/widgets/button_default.dart';
import 'package:flutter_riverpod_best_practices/core/constants/app_colors.dart';
import 'package:flutter_riverpod_best_practices/core/constants/app_sizes.dart';
import 'package:flutter_riverpod_best_practices/core/constants/app_text_styles.dart';
import 'package:flutter_riverpod_best_practices/core/constants/asset_const.dart';
import 'package:flutter_riverpod_best_practices/config/router/route_const.dart';
import 'package:flutter_riverpod_best_practices/core/error/app_exception.dart';
import 'package:flutter_riverpod_best_practices/core/utils/validators.dart';
import 'package:flutter_riverpod_best_practices/di/service_locator.dart';
import 'package:flutter_riverpod_best_practices/features/auth/presentation/providers/log_in_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/utils/functions.dart';

class LoginScreen extends HookConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final phoneController = useTextEditingController(text: "");
    final phoneNumber = useState("");
    ref.listen(loginProvider, (pre, next) {
      if (!context.mounted || !(ModalRoute.of(context)?.isCurrent ?? false)) {
        return;
      }
      if (next.isLoading) {
        SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.black);
        SVProgressHUD.show();
      } else {
        SVProgressHUD.dismiss();
        if (next.data != null) {
          next.data!.fold(
            (l) {
              final errorMessage = switch (l) {
                NetworkException() => 'No internet connection',
                ServerException(:final message) => message,
                UnauthorizedException(:final message) => message,
                BadRequestException(:final message) => message,
                UnknownException(:final message) => message,
              };
              // SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.custom);
              // SVProgressHUD.setForegroundColor(Colors.white);
              // SVProgressHUD.setBackgroundColor(Colors.black.withOpacity(0.8));
              // SVProgressHUD.showInfo(status: errorMessage);
              // Fluttertoast.showToast(
              //   msg: errorMessage,
              //   toastLength: Toast.LENGTH_SHORT,
              //   gravity: ToastGravity.CENTER,
              //   backgroundColor: Colors.black.withOpacity(0.8),
              //   textColor: Colors.white,
              //   fontSize: 16.0,
              // );
              showErrorDialog(context, errorMessage);
              //print(l.toString()); // Or show as Snackbar/dialog
            },
            (r) {
              if (r.hash != null) {
                context.pushNamed(
                  RouteConst.otpVerification,
                  extra: ["+1${phoneController.text}", r.hash],
                );
              } else {
                context.pushNamed(
                  RouteConst.loginInfo,
                  extra: ["+1${phoneController.text}"],
                );
              }
            },
          );
        }
      }
    });

    final formKey = useMemoized(() => GlobalKey<FormState>());

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBarDefault(title: "Log In"),
      body: SingleChildScrollView(
        reverse: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            kGapXXXL,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 20,
                      width: 20,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.primaryColor,
                      ),
                      child: Icon(
                        Icons.check,
                        color: AppColors.white,
                        size: 12.0,
                      ),
                    ),
                    kGapXS,
                    Text(
                      "Log In",
                      style: AppTextStyles.shortInfoTS,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                kGapM,

                Container(
                  margin: EdgeInsets.only(top: 10),
                  height: 3,
                  width: 21,
                  decoration: BoxDecoration(
                    color: AppColors.border,
                    borderRadius: BorderRadius.circular(2.0),
                  ),
                ),
                kGapM,

                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 20,
                      width: 20,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.white,
                        border: Border.all(
                          color: AppColors.primaryColor,
                          width: 0.5,
                        ),
                      ),
                      child: Icon(
                        Icons.circle,
                        color: AppColors.primaryColor,
                        size: 12.0,
                      ),
                    ),
                    kGapS,
                    Text(
                      "Info",
                      style: AppTextStyles.shortInfoTS,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),

                kGapM,

                Container(
                  margin: EdgeInsets.only(top: 10),
                  height: 3,
                  width: 21,
                  decoration: BoxDecoration(
                    color: AppColors.border,
                    borderRadius: BorderRadius.circular(2.0),
                  ),
                ),
                kGapM,

                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 20,
                      width: 20,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.border,
                      ),
                      // child: Icon(
                      //   Icons.check,
                      //   color: AppColors.white,
                      //   size: 12.0,
                      // ),
                    ),
                    kGapXS,
                    Text(
                      "OTP",
                      style: AppTextStyles.shortInfoTS,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ],
            ),

            kGapXXXXL,

            Image.asset(AssetConst.logInBG, height: 331, width: 375),

            kGapXXL,
            Padding(
              padding: const EdgeInsets.all(16.0).copyWith(top: 0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Get started with Flutter Best Practice",
                        style: AppTextStyles.subTitleTS,
                      ),
                    ),

                    kGapXXL,
                    Container(
                      // padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: AppColors.border),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 8, 10, 8),
                            child: Image.asset(
                              AssetConst.canada,
                              height: 32,
                              width: 32,
                            ),
                          ),
                          Text(
                            "+1",
                            style: AppTextStyles.subTitleTS.copyWith(
                              color: AppColors.blackSecondary,
                            ),
                          ),
                          kGapM,

                          Container(
                            height: 24,
                            width: 2,
                            color: AppColors.border,
                          ),
                          kGapM,

                          Expanded(
                            child: TextFormField(
                              onChanged: (text) {
                                phoneNumber.value = text;
                              },
                              maxLength: 10,
                              validator:
                                  (text) =>
                                      getIt<Validators>().phoneValidator(text),
                              keyboardType: TextInputType.phone,
                              controller: phoneController,
                              style: AppTextStyles.subTitleTS.copyWith(
                                color: AppColors.blackSecondary,
                                letterSpacing: 1.1,
                                fontWeight: FontWeight.w500,
                              ),

                              decoration: InputDecoration(
                                counterText: '',
                                hintStyle: AppTextStyles.hintTS.copyWith(
                                  fontSize: 12,
                                ),
                                hintText: "Enter your 10 digit Phone number",
                                border: InputBorder.none,

                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    kGapXXL,
                    ButtonDefault.expanded(
                      title: "Continue",
                      onPressed:
                          phoneNumber.value.length == 10
                              ? () {
                                if (formKey.currentState!.validate()) {
                                  ref
                                      .read(loginProvider.notifier)
                                      .login("+1${phoneController.text}");
                                }
                              }
                              : null,
                    ),
                    //SizedBox(height: MediaQuery.viewInsetsOf(context).bottom),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
