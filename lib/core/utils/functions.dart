import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

import '../common/widgets/dialog_container.dart';
import '../common/widgets/image_upload_bottomsheet.dart';
import '../constants/app_colors.dart';
import '../constants/app_const.dart';
import '../constants/app_text_styles.dart';
// Future<void> saveAndLaunchFile(List<int> bytes, String fileName) async {
// //Get external storage directory
//   Directory directory = await getApplicationSupportDirectory();
// //Get directory path
//   String path = directory.path;
// //Create an empty file to write PDF data
//   File file = File('$path/$fileName');
// //Write PDF data
//   await file.writeAsBytes(bytes, flush: true);
// //Open the PDF document in mobile
//   OpenFile.open('$path/$fileName');
// }

  void showErrorDialog(BuildContext context, String message) {
    showCupertinoDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (BuildContext context) => CupertinoAlertDialog(
            content: Text(message, style: TextStyle(fontSize: 16)),
            actions: <CupertinoDialogAction>[
              CupertinoDialogAction(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
    );
  }

Future<XFile?> chooseImageMultipart({fromCamera = false}) async {
  final pickedFile = await ImagePicker().pickImage(
    source: fromCamera ? ImageSource.camera : ImageSource.gallery,
    maxWidth: 1800,
    maxHeight: 1800,
  );
  if (pickedFile != null) {
    return XFile(pickedFile.path);
  }
  return null;
}

void showCustomImageUploadBottomSheet(
  context,
  Function() onSelectCamera,
  Function() onSelectGallery,
) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
    ),
    builder: (context) {
      return ImageUploadBottomSheet(onSelectCamera, onSelectGallery);
    },
  );
}

chooseImage(BuildContext context, Function(String imagePath) onChooseImage) {
  showCustomImageUploadBottomSheet(
    context,
    () async {
      Navigator.of(context).pop();
      XFile? selectedImage = await chooseImageMultipart(fromCamera: true);
      onChooseImage(selectedImage!.path);
    },
    () async {
      Navigator.of(context).pop();
      XFile? selectedImage = await chooseImageMultipart();
      if (selectedImage != null) {
        onChooseImage(selectedImage.path);
      }
    },
  );
}

Future<void> copyToClipboard(BuildContext context, String text) async {
  await Clipboard.setData(ClipboardData(text: text));
  if (context.mounted) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Copied to clipboard')));
  }
}

void openDialer(String phoneNumber) async {
  final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
  if (await canLaunchUrl(phoneUri)) {
    await launchUrl(phoneUri);
  } else {
    throw 'Could not launch $phoneUri';
  }
}

void openMail(String email, String subject, String body) async {
  final Uri emailUri = Uri(
    scheme: 'mailto',
    path: email,
    queryParameters: {'subject': subject, 'body': body},
  );
  if (await canLaunchUrl(emailUri)) {
    await launchUrl(emailUri);
  } else {
    throw 'Could not launch $emailUri';
  }
}

void openWhatsApp(String whatsAppNumber, String message) async {
  final Uri whatsappUri = Uri(
    scheme: 'https',
    host: 'wa.me',
    path: whatsAppNumber,
    queryParameters: {'text': message},
  );

  if (await canLaunchUrl(whatsappUri)) {
    await launchUrl(whatsappUri);
  } else {
    throw 'Could not launch $whatsappUri';
  }
}

// void showAlertDialog(BuildContext context, {String? title, String? message}) {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         actionsAlignment: MainAxisAlignment.center,
//         alignment: Alignment.center,
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             SizedBoxes.mediumPlusHeight,
//             // Load a Lottie file from your assets
//             Lottie.asset(
//               AppAssets.warningJSON,
//               height: 96,
//               width: 96,
//             ),
//             // const AnimatedIcon(),
//             SizedBoxes.mediumHeight,
//             Text(
//               title ?? 'Oops!',
//               style: TextStyles.textStyleTitleLarge.copyWith(fontSize: 32),
//             ),
//             SizedBoxes.mediumHeight,
//             Text(
//               textAlign: TextAlign.center,
//               message ??
//                   'Please update the product inventory type to "With Inventory" ',
//               style: TextStyles.textStyleBody
//                   .copyWith(height: 1.7, color: Colors.black87),
//             ),
//           ],
//         ),
//         actions: [
//           CustomMaterialButton(
//             borderRadius: 32,
//             width: 72,
//             padding: const EdgeInsets.fromLTRB(18, 8, 18, 8),
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//             title: "Okay",
//             gradient: AppGradients.primaryGradient,
//           )
//         ],
//       );
//     },
//   );
// }

// void showDeleteDialog(BuildContext context, Function() onDeleteClick,
//     {String? title = "Attention Please!",
//     String? message = "Do you want to delete this item?"}) {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         actionsAlignment: MainAxisAlignment.center,
//         alignment: Alignment.center,
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             SizedBoxes.mediumPlusHeight,
//             // Load a Lottie file from your assets
//             Lottie.asset(AppAssets.warningJSON,
//                 height: 96, width: 96, repeat: false),
//             // const AnimatedIcon(),
//             SizedBoxes.mediumHeight,
//             Text(
//               title ?? 'Oops!',
//               style: TextStyles.textStyleTitleLarge.copyWith(fontSize: 22),
//             ),
//             SizedBoxes.mediumHeight,
//             Text(
//               textAlign: TextAlign.center,
//               message ??
//                   'Please update the product inventory type to "With Inventory" ',
//               style: TextStyles.textStyleBody
//                   .copyWith(height: 1.7, color: Colors.black87),
//             ),
//           ],
//         ),
//         actions: [
//           CustomMaterialButton(
//             borderRadius: 32,
//             width: 72,
//             padding: const EdgeInsets.fromLTRB(18, 8, 18, 8),
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//             title: "No",
//             gradient: AppGradients.primaryGradient,
//           ),
//           SizedBoxes.extraSmallWidth,
//           CustomMaterialButton(
//             borderRadius: 32,
//             width: 72,
//             padding: const EdgeInsets.fromLTRB(18, 8, 18, 8),
//             onPressed: () {
//               onDeleteClick();
//             },
//             title: "Yes",
//             gradient: AppGradients.deleteGradient,
//           )
//         ],
//       );
//     },
//   );
// }

// showDeleteDialogOld(BuildContext context, Function() onDeleteClick,
//     {String title = "Are you sure ?",
//     String? message = "Do you want to delete this item?"}) {
//   showGeneralDialog(
//       context: context,
//       barrierLabel: '',
//       barrierDismissible: true,
//       pageBuilder: (context, _, __) {
//         return Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Container(
//               margin: const EdgeInsets.fromLTRB(16, 16, 16, 16),
//               padding: const EdgeInsets.fromLTRB(16, 24, 16, 28),
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(16), color: Colors.white),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   SizedBoxes.mediumPlusHeight,
//                   Lottie.asset(AppAssets.warningJSON, height: 96, width: 96),
//                   SizedBoxes.largeHeight,
//                   Text(
//                     title,
//                     style: TextStyles.textStyleTitle.copyWith(fontSize: 18),
//                   ),
//                   if (message != null) SizedBoxes.smallPlusHeight,
//                   if (message != null)
//                     Text(
//                       message,
//                       style: TextStyles.textStyleBody
//                           .copyWith(height: 1.7, color: Colors.black87),
//                     ),
//                   SizedBoxes.mediumPlusHeight,
//                   Row(
//                     children: [
//                       Expanded(
//                           child: CustomMaterialButton(
//                         gradient: AppGradients.primaryGradient,
//                         onPressed: () {
//                           context.pop();
//                         },
//                         title: "No",
//                         fontSize: 16,
//                       )),
//                       SizedBoxes.largeWidth,
//                       Expanded(
//                           child: CustomMaterialButton(
//                         gradient: AppGradients.deleteGradient,
//                         onPressed: () {
//                           onDeleteClick();
//                         },
//                         title: "Yes",
//                         fontSize: 16,
//                       )),
//                     ],
//                   )
//                 ],
//               ),
//             )
//           ],
//         );
//       });
// }

// showCustomSnackBar(BuildContext context, String message,
//     {Alignment alignment = Alignment.topCenter, double distance = 110}) async {
//   final snackBar = SnackBar(
//     elevation: 0.0,
//     content: CustomAnimatedSnackbar(message: message),
//     backgroundColor: Colors.transparent,
//     duration: const Duration(seconds: 3),
//     shape: const RoundedRectangleBorder(
//       borderRadius: BorderRadius.only(
//           topRight: Radius.circular(20), topLeft: Radius.circular(20)),
//     ),
//     behavior: SnackBarBehavior.floating,
//     margin: EdgeInsets.fromLTRB(
//       20,
//       0, // alignment==Alignment.topCenter?  Get.height-distance: distance,
//       20,
//       alignment == Alignment.topCenter
//           ? MediaQuery.of(context).size.height - distance
//           : //Get.height-distance
//           //  alignment==Alignment.bottomCenter?  distance :
//           alignment == Alignment.center
//               ? (MediaQuery.of(context).size.height / 2)
//               : distance, //(Get.height/2)
//     ),
//     padding: const EdgeInsets.symmetric(horizontal: 16),
//   );
//
//   WidgetsBinding.instance.addPostFrameCallback((_) {
//     ScaffoldMessenger.of(scaffoldKey.currentState!.context)
//         .showSnackBar(snackBar);
//   });
// }

Widget generateCustomPositionDialogListContent(
  List<String> itemList,
  Function(int itemIndex) onItemTap,
) {
  return SingleChildScrollView(
    child: Container(
      padding: const EdgeInsets.fromLTRB(0, 4, 0, 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(5, 5),
          ),
          BoxShadow(
            color: Colors.grey.shade300,
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(-2, 5),
          ),
        ],
      ),
      child: IntrinsicWidth(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: List.generate(itemList.length, (itemIndex) {
            return Material(
              color: Colors.transparent,
              child: InkWell(
                splashColor: AppColors.primaryColor.withAlpha(
                  (0.3 * 255).toInt(),
                ),
                onTap: () {
                  onItemTap(itemIndex);
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12, 7, 12, 7),
                  child: Text(itemList[itemIndex], style: AppTextStyles.btnTS),
                ),
              ),
            );
          }),
        ),
      ),
    ),
  );
}

void showCustomPositionedDialog(
  BuildContext context,
  GlobalKey containerKey,
  Widget content, {
  bool showFromBorder = true,
  bool fixMinWidthWithParent = true,
  bool fixMaxWidthWithParent = true,
  double? contentMaxHeight,
}) {
  final Size screenFullSize = MediaQuery.of(context).size;

  final RenderBox renderBox =
      containerKey.currentContext!.findRenderObject() as RenderBox;
  final position = renderBox.localToGlobal(Offset.zero);

  final size = renderBox.size;
  double top =
      position.dy + (showFromBorder ? size.height : 0) - globalStatusBarHeight;
  final double topWithContentMaxHeight = (top + (contentMaxHeight ?? 0.0));

  if (topWithContentMaxHeight > screenFullSize.height) {
    top =
        position.dy -
        ((contentMaxHeight ?? 0.0) + 2) +
        (showFromBorder ? 0 : size.height);
  }

  showDialog(
    context: context,
    barrierColor: Colors.transparent,
    builder: (BuildContext context) {
      return Stack(
        children: <Widget>[
          Positioned(
            top:
                topWithContentMaxHeight <=
                        (screenFullSize.height -
                            MediaQuery.of(context)
                                .viewInsets
                                .bottom) //after showing keyboard, if remain screen is enough for showing dialog
                    ? top
                    : (top -
                        (topWithContentMaxHeight -
                            (screenFullSize.height -
                                MediaQuery.of(
                                  context,
                                ).viewInsets.bottom) //remaining screen
                            )),
            left: position.dx,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: fixMinWidthWithParent ? size.width : 0,
                maxWidth:
                    fixMaxWidthWithParent ? size.width : screenFullSize.width,
                minHeight: 0,
                maxHeight: screenFullSize.height,
              ),
              child: content,
            ),
          ),
        ],
      );
    },
  );
}

Offset getOffsetFromGlobalKey(
  GlobalKey globalKey, {
  bool showFromBottomEdge = true,
  bool showFromRightEdge = true,
}) {
  RenderBox renderBox =
      globalKey.currentContext!.findRenderObject() as RenderBox;
  return (renderBox.localToGlobal(Offset.zero)).translate(
    showFromRightEdge ? renderBox.size.width : 0,
    showFromBottomEdge ? renderBox.size.height : 0,
  );
}

showDropDownPopUpMenu(
  BuildContext context,
  GlobalKey containerKey,
  List<PopupMenuItem> menuList, {
  bool showFromBottomEdge = false,
}) async {
  // final RenderBox renderBox =
  // containerKey.currentContext!.findRenderObject() as RenderBox;
  // final position = renderBox.localToGlobal(Offset.zero);
  // final size = renderBox.size;

  final RenderBox renderBox =
      containerKey.currentContext!.findRenderObject() as RenderBox;
  final position = renderBox
      .localToGlobal(Offset.zero)
      .translate(
        0,
        -AppBar().preferredSize.height - 50,
      ); //Removing AppBar Height(AppBar().preferredSize.height) and Bottom Navigation Bar height (50)

  final size = renderBox.size;

  await showMenu(
    context: context,
    elevation: 8,
    color: Colors.white,
    popUpAnimationStyle: AnimationStyle(
      curve: Curves.easeInOut,
      duration: const Duration(milliseconds: 500),
    ),
    position: RelativeRect.fromLTRB(
      position.dx,
      position.dy + (showFromBottomEdge ? size.height : 0),
      position.dx + size.width,
      position.dy,
    ),
    // position: RelativeRect.fromLTRB(
    //   position.dx,
    //   position.dy + (showFromBottomEdge ? size.height : 0),
    //   position.dx + size.width,
    //   position.dy + (showFromBottomEdge ? size.height : 0) - 200,
    // ),
    items: menuList,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  );
}

showPositionedPopUpMenu(
  BuildContext context,
  Offset offset,
  List<PopupMenuItem> menuList,
) async {
  offset = offset.translate(
    0,
    -AppBar().preferredSize.height - 50,
  ); //Removing AppBar Height(AppBar().preferredSize.height) and Bottom Navigation Bar height (50)

  await showMenu(
    context: context,
    elevation: 8,
    color: Colors.white,
    popUpAnimationStyle: AnimationStyle(curve: Curves.fastOutSlowIn),
    position: RelativeRect.fromLTRB(
      offset.dx,
      offset.dy,
      MediaQuery.of(context).size.width - offset.dx,
      MediaQuery.of(context).size.height - offset.dy,
    ),
    items: menuList,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  );
}

void showCustomDialog(
  BuildContext context,
  String title,
  Widget content, {
  double? minHeight,
  double? maxHeight,
  Color? background,
  Function()? onDismiss,
}) {
  minHeight ??= 100;
  maxHeight ??= MediaQuery.of(context).size.height * 0.8;
  background ??= Colors.grey.shade100;

  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: '',
    barrierColor: Colors.black54,
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (context, anim1, anim2) {
      return Align(
        alignment: Alignment.bottomCenter,
        child: DialogContainer(
          title,
          minHeight!,
          maxHeight!,
          content,
          background: background,
          onDismiss: onDismiss,
        ),
      );
    },
    transitionBuilder: (context, anim1, anim2, child) {
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 1),
          end: const Offset(0, 0),
        ).animate(CurvedAnimation(parent: anim1, curve: Curves.easeInOut)),
        child: child,
      );
    },
  );
}

LinearGradient generateLinearGradient(List<Color> colors) {
  return LinearGradient(
    begin: Alignment.bottomLeft,
    end: Alignment.topRight, //const Alignment(0.8, 1),
    colors: colors,
    tileMode: TileMode.mirror,
  );
}
