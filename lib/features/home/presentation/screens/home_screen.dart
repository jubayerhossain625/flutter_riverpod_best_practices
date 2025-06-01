import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod_best_practices/core/constants/app_colors.dart';
import 'package:flutter_riverpod_best_practices/core/constants/app_sizes.dart';
import 'package:flutter_riverpod_best_practices/core/constants/app_text_styles.dart';
import 'package:flutter_riverpod_best_practices/core/constants/asset_const.dart';
import 'package:flutter_riverpod_best_practices/features/home/presentation/widgets/card_slider.dart';
import 'package:flutter_riverpod_best_practices/features/home/presentation/widgets/search_widget.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/common/providers/auth_notifier.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    final selectedIndex = useState(0);
  

    void onItemTapped(int index) {
      selectedIndex.value = index;
    }

    void openCloseEndDrawer() {
      if (scaffoldKey.currentState!.isDrawerOpen) {
        scaffoldKey.currentState!.closeEndDrawer();
      } else {
        scaffoldKey.currentState!.openEndDrawer();
      }
    }

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        titleSpacing: 0, // Ensures full width usage
        toolbarHeight: 70, // Adjust height if needed
        leading: SizedBox(width: 0),
        leadingWidth: 0,
        automaticallyImplyLeading: false,
        flexibleSpace: SafeArea(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            alignment: Alignment.centerLeft,
            child: SearchWidget(onMenuChanged: () => openCloseEndDrawer()),
          ),
        ),

        actions: [SizedBox()],
      ),

      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Explore'),
          BottomNavigationBarItem(
            icon: Icon(Icons.work_outline_rounded),
            label: 'Pros',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline_rounded),
            label: 'Post',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.chat_bubble_text),
            label: 'Chatbox',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.bell),
            label: 'Notification',
          ),
        ],
        currentIndex: selectedIndex.value,
        selectedItemColor: AppColors.primaryColor,
        unselectedItemColor: AppColors.blackPrimary,
        unselectedLabelStyle: TextStyle(
          color: AppColors.black,
          fontWeight: FontWeight.w500,
        ),
        selectedLabelStyle: TextStyle(
          color: AppColors.primaryColor,
          fontWeight: FontWeight.w500,
        ),

        showUnselectedLabels: true,

        onTap: onItemTapped,
      ),

      endDrawer: Drawer(
        width: 300,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(color: Colors.blue),
              padding: EdgeInsets.zero,

              child: SizedBox(
                height: 200,
                width: 300,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned.fill(
                      child: Image.asset(
                        AssetConst.drawerHeadingBG,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        kGapXL,
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.white,
                          ),
                          // padding: const EdgeInsets.all(4.0),
                          height: 104,
                          width: 104,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: CircleAvatar(
                              backgroundColor: AppColors.white,
                              child: Image.asset(AssetConst.appIcon),
                            ),
                          ),
                        ),
                        kGapXL,
                        Text(
                          "Md. Abdullah",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: AppColors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            kGapL,
            ListTile(
              leading: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.iconBG,
                ),

                child: const Icon(Icons.person),
              ),
              title: const Text('Profile', style: AppTextStyles.menuTS),
              onTap: () {},
            ),
            kGapM,
            ListTile(
              leading: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.iconBG,
                ),
                child: const Icon(Icons.file_open_outlined),
              ),
              title: const Text('Order History', style: AppTextStyles.menuTS),
              onTap: () {},
            ),
            kGapM,
            ListTile(
              leading: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.iconBG,
                ),
                child: const Icon(Icons.favorite),
              ),
              title: const Text('Favorites', style: AppTextStyles.menuTS),
              onTap: () {},
            ),
            kGapM,
            ListTile(
              leading: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.iconBG,
                ),
                child: const Icon(Icons.swap_horizontal_circle_outlined),
              ),
              title: Text(
                'Switch Account',
                style: AppTextStyles.menuTS,
              ),
              onTap: () {

              },
            ),
            kGapM,
            ListTile(
              leading: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.iconBG,
                ),
                child: const Icon(Icons.help_outline_outlined),
              ),
              title: const Text('Help', style: AppTextStyles.menuTS),
              onTap: () {},
            ),
            kGapM,
            ListTile(
              leading: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.iconBG,
                ),
                child: const Icon(Icons.logout_outlined),
              ),
              title: const Text('Log Out', style: AppTextStyles.menuTS),
              onTap: () {
                ref.read(authNotifierProvider.notifier).logout();

              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [ kGapM, CardSlider(),kGapXXXXL,],
          ),
        ),
      ),
    );
  }
}
