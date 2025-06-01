import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svprogresshud/flutter_svprogresshud.dart';
import 'package:flutter_riverpod_best_practices/config/router/route_const.dart';
import 'package:flutter_riverpod_best_practices/core/common/widgets/appbar_default.dart';
import 'package:flutter_riverpod_best_practices/core/common/widgets/button_default.dart';
import 'package:flutter_riverpod_best_practices/core/common/widgets/scaffold_default.dart';
import 'package:flutter_riverpod_best_practices/core/common/widgets/text_field_default.dart';
import 'package:flutter_riverpod_best_practices/core/error/app_exception.dart';
import 'package:flutter_riverpod_best_practices/core/utils/functions.dart';
import 'package:flutter_riverpod_best_practices/core/utils/validators.dart';
import 'package:flutter_riverpod_best_practices/di/service_locator.dart';
import 'package:flutter_riverpod_best_practices/features/auth/presentation/providers/log_in_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/common/providers/location_provider.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/constants/asset_const.dart';
import '../../domain/usecases/log_in_info_usecase.dart';
import '../providers/login_info_submit_provider.dart';

class LoginInfoScreen extends HookConsumerWidget {
  final String phoneNumber;
  const LoginInfoScreen({super.key, required this.phoneNumber});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameController = useTextEditingController();
    final emailController = useTextEditingController();
    final addressController = useTextEditingController();
    final phoneForCustomerController = useTextEditingController();

    final name = useState<String?>(nameController.text);
    final email = useState<String?>(emailController.text);
    final address = useState<String?>(addressController.text);
    final phoneNumberForCustomer = useState("");

    final imagePath = useState<String?>(null);
    final acceptance = useState(false);
    final formKey = GlobalKey<FormState>();


    WidgetsBinding.instance.addPostFrameCallback((d) {
      ref.read(locationProvider.notifier).refreshLocation();
    });

    ref.listen(locationProvider, (pre, next) async {
      if (next.isLoading) {
      } else {
       
        ref.read(loginInfoSubmitUseCaseProvider);
        if (next.data != null) {
          next.data!.fold(
            (l) {
             // print("next.data get error: ${l.parseError()}");
            },
            (r) {
            //  print("next.data get position: ${r.position}");
              address.value = r.address;
              addressController.text = r.address;
            },
          );
        }
      }
    });

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
                  extra: [phoneNumber, r.hash],
                );
                
              } else {
                showErrorDialog(context, "Error: Hash not found");
              }
            },
          );
        }
      }
    });

    ref.listen(loginInfoSubmitProvider, (pre, next) {
      if (next.isLoading) {
        SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.black);
        SVProgressHUD.show();
      } else {
        SVProgressHUD.dismiss();
        if (next.data != null) {
          next.data!.fold(
            (l) {
              showErrorDialog(context, l.parseError());
            },
            (r) async {
              //print("UserInfo: ${r.toJson().toString()}");
              if (r.hash != null) {
                // showErrorDialog(
                //   context,
                //   "Registration successful, Please login now!",
                // );

                ref.read(loginProvider.notifier).login(phoneNumber);
              } else {
                showErrorDialog(context, "Something Went Wrong");
              }
            },
          );
        }
      }
    });

    return ScaffoldDefault(
      appBar: AppBarDefault(title: "Information", onBackPressed: () {}),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              kGapXXXL,
              progressStatusWidget,

              kGapXXXL,
              kGapL,

              Center(
                child: SizedBox(
                  height: 118,
                  width: 118,
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Positioned.fill(
                        child: Container(
                          padding: EdgeInsets.all(
                            imagePath.value == null ? 20 : 0,
                          ),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.imageBG,
                          ),
                          child:
                              imagePath.value == null
                                  ? Icon(
                                    CupertinoIcons.camera_fill,
                                    size: 32,
                                    color: AppColors.inactiveIconColor,
                                  )
                                  : ClipRRect(
                                    borderRadius: BorderRadius.circular(59),
                                    child: Image.file(
                                      File(imagePath.value!),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                        ),
                      ),

                      GestureDetector(
                        onTap: () {
                          chooseImage(context, (String path) {
                            imagePath.value = path;
                          });
                        },
                        child: CircleAvatar(
                          radius: 18,
                          backgroundColor: AppColors.white,
                          child: Padding(
                            padding: EdgeInsets.all(3),
                            child: CircleAvatar(
                              child: Icon(Icons.edit_outlined, size: 16),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              //Image.asset(AssetConst.logInBG, height: 118, width: 118),
              kGapXXL,

              Text("Your Name", style: AppTextStyles.labelTS),
              kGapM,
              TextFieldDefault(
                prefixIcon: Icons.person,
                hint: "Enter your name",
                controller: nameController,
                validator: getIt<Validators>().requiredField,
                onChanged: (text) => name.value = text,
              ),
              kGapXL,
              Text("Your Email", style: AppTextStyles.labelTS),
              kGapM,
              TextFieldDefault(
                prefixIcon: CupertinoIcons.mail_solid,
                hint: "Enter your email",
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                validator: getIt<Validators>().emailValidator,
                onChanged: (text) => email.value = text,
              ),
              if (true) ...[
                kGapL,
                Text(
                  "Contact number for customers",
                  style: AppTextStyles.labelTS,
                ),
                kGapM,
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

                      Container(height: 24, width: 2, color: AppColors.border),
                      kGapM,

                      Expanded(
                        child: TextField(
                          onChanged: (text) {
                            phoneNumberForCustomer.value = text;
                          },
                          keyboardType: TextInputType.phone,
                          controller: phoneForCustomerController,
                          style: AppTextStyles.subTitleTS.copyWith(
                            color: AppColors.blackSecondary,
                            letterSpacing: 1.1,
                            fontWeight: FontWeight.w500,
                          ),
                          decoration: InputDecoration(
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
              ],
              kGapXL,
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Address/Area", style: AppTextStyles.labelTS),
                  kGapM,
                  Icon(
                    Icons.info_outline,
                    color: AppColors.primaryColor,
                    size: 18,
                  ),
                ],
              ),
              kGapM,
              TextFieldDefault(
                prefixIcon: Icons.location_on,
                hint: "Enter address/area",
                controller: addressController,
                validator: getIt<Validators>().requiredField,
                onChanged: (text) => address.value = text,
              ),
              kGapXXL,
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20,
                    width: 20,
                    child: Checkbox(
                      value: acceptance.value,
                      onChanged: (value) {
                        acceptance.value = !acceptance.value;
                      },
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      visualDensity: VisualDensity(),
                      //splashRadius: 0,
                    ),
                  ),
                  kGapXL,
                  RichText(
                    text: TextSpan(
                      text: "Accept ",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textColor,
                      ),
                      children: [
                        TextSpan(
                          text: "terms & conditions and privacy policy",
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              kGapXXXL,

              ButtonDefault.expanded(
                title: "Get Started",
                onPressed:
                    acceptance.value && imagePath.value != null
                        ? () async {
                          if (formKey.currentState!.validate()) {
                            ref
                                .read(loginInfoSubmitProvider.notifier)
                                .submitLogInInfo(
                                  fullName: nameController.text,
                                  email: emailController.text,
                                  phone: phoneNumber,
                                  address: addressController.text,
                                  files: [File(imagePath.value!)],
                                );
                          }
                        }
                        : null,
              ),
              const SizedBox(height: 60),
            ],
          ),
        ),
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
              color: AppColors.white,
              border: Border.all(color: AppColors.primaryColor, width: 0.5),
            ),
            child: Icon(
              Icons.circle,
              color: AppColors.primaryColor,
              size: 12.0,
            ),
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
