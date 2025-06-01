import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod_best_practices/core/common/providers/auth_notifier.dart';
import 'package:flutter_svprogresshud/flutter_svprogresshud.dart';
import 'package:flutter_riverpod_best_practices/config/router/route_const.dart';
import 'package:flutter_riverpod_best_practices/core/common/widgets/appbar_default.dart';
import 'package:flutter_riverpod_best_practices/core/common/widgets/button_default.dart';
import 'package:flutter_riverpod_best_practices/core/common/widgets/scaffold_default.dart';
import 'package:flutter_riverpod_best_practices/core/error/app_exception.dart';
import 'package:flutter_riverpod_best_practices/features/auth/presentation/providers/verify_otp_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pinput/pinput.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/utils/functions.dart';

class OtpScreen extends HookConsumerWidget {
  final String phoneNumber;
  final String hash;
  const OtpScreen({super.key, required this.phoneNumber, required this.hash});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final otp = useState<String>("");
    ref.listen(verifyOtpProvider, (pre, next) {
      if (next.isLoading) {
        
      } else {
        SVProgressHUD.dismiss();
        if (next.data != null) {
          next.data!.fold(
            (l) {
              showErrorDialog(context, l.parseError());
            },
            (r) async {
              if (r.userId != null) {
                ref.read(authNotifierProvider.notifier).saveLogin(userId: r.userId!, accessToken: r.accessToken!, refreshToken: r.refreshToken!,phoneNumber: phoneNumber);
                context.goNamed(RouteConst.home);
              } else {
                context.pushNamed(RouteConst.loginInfo, extra: [phoneNumber]);
              }
            },
          );
        }
      }
    });
    return ScaffoldDefault(
      appBar: AppBarDefault(title: "One Time Password"),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          kGapXXXL,
          progressStatusWidget,
          kGapXXXL,
          kGapL,

          Expanded(child: SizedBox()),
          Pinput(
            length: 6,
            defaultPinTheme: PinTheme(
              width: 44,
              height: 50,
              textStyle: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue),
                borderRadius: BorderRadius.circular(4),
              ),
            ),

            onCompleted: (pin) {
              otp.value = pin;
            },
          ),
          kGapXXXL,
          Text(
            "*Enter 6 digit One Time Password(OTP)  that already sent to your phone number",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.textInfo,
            ),
          ),
          Expanded(child: SizedBox()),

          GestureDetector(
            onTap: () => context.goNamed(RouteConst.login),
            child: Text(
              "Change phone Number",
              style: TextStyle(
                color: AppColors.primaryColor,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 40),
          ButtonDefault.expanded(
            title: "Verify",
            onPressed:
                otp.value.isNotEmpty && otp.value.length == 6
                    ? () {
                      ref
                          .read(verifyOtpProvider.notifier)
                          .verifyOTP(phoneNumber, otp.value, hash);
                    }
                    : null,
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget get progressStatusWidget => Row(
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
            child: Icon(Icons.check, color: AppColors.white, size: 12.0),
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
              color: AppColors.primaryColor,
            ),
            child: Icon(Icons.check, color: AppColors.white, size: 12.0),
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
              color: AppColors.primaryColor,
            ),
            child: Icon(Icons.check, color: AppColors.white, size: 12.0),
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
  );
}
