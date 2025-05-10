import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodtek/core/responseve.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import '../../../constant/colors.dart';
import '../../../constant/main_screen/main_screen_data.dart';
import '../../../cubit/theme_cubit.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late PersistentTabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
    _controller.addListener(() {
      setState(() {});
    });
  }

  List<Widget> _buildScreens() {
    return pages;
  }

  // to generate the bottom sheet items
  // List<PersistentBottomNavBarItem> _navBarsItems() {
  //   return List.generate(5, (index) {
  //     bool isCart = index == 2; // Assuming cart is at index 2
  //     return PersistentBottomNavBarItem(
  //       // the item for the bottom bar
  //       icon: Column(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         crossAxisAlignment: CrossAxisAlignment.center,
  //         children: [
  //           isCart
  //               ? Center(
  //                 child: Image.asset(
  //                   bottomNavImages[index],
  //                   width: responsiveWidth(context, 30),
  //                   height: responsiveHeight(context, 30),
  //                   color: Colors.white,
  //                 ),
  //               )
  //               : Image.asset(
  //                 // the icon
  //                 bottomNavImages[index],
  //                 width: responsiveWidth(context, 24),
  //                 height: responsiveHeight(context, 24),
  //                 color:
  //                     index == _controller.index
  //                         ? AppColors.primaryColor
  //                         : Colors.grey,
  //               ),
  //           Visibility(
  //             visible: !isCart,
  //             child: Text(
  //               isCart ? '' : bottomNavLabels[index],
  //               style: TextStyle(
  //                 fontSize: 12,
  //                 decoration: TextDecoration.none,
  //                 color:
  //                     index == _controller.index
  //                         ? AppColors.primaryColor
  //                         : Colors.grey,
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //
  //       activeColorPrimary: AppColors.primaryColor,
  //       inactiveColorPrimary: Colors.grey,
  //     );
  //   });
  // }
  List<PersistentBottomNavBarItem> _navBarsItems(BuildContext context) {
    final localizedLabels = getBottomNavLabels(context); // ← grab localized text

    return List.generate(5, (index) {
      bool isCart = index == 2;

      return PersistentBottomNavBarItem(
        icon: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            isCart
                ? Center(
              child: Image.asset(
                bottomNavImages[index],
                width: responsiveWidth(context, 30),
                height: responsiveHeight(context, 30),
                color: Colors.white,
              ),
            )
                : Image.asset(
              bottomNavImages[index],
              width: responsiveWidth(context, 24),
              height: responsiveHeight(context, 24),
              color: index == _controller.index
                  ? AppColors.primaryColor
                  : Colors.grey,
            ),
            Visibility(
              visible: !isCart,
              child: Text(
                localizedLabels[index], // ← localized label here
                style: TextStyle(
                  fontSize: 12,
                  decoration: TextDecoration.none,
                  color: index == _controller.index
                      ? AppColors.primaryColor
                      : Colors.grey,
                ),
              ),
            ),
          ],
        ),
        activeColorPrimary: AppColors.primaryColor,
        inactiveColorPrimary: Colors.grey,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      // the bottom sheet
      navBarHeight: 61,
      backgroundColor:
      context
          .watch<ThemeCubit>()
          .state ==
          ThemeMode.light
          ? Color.fromRGBO(219, 244, 209, 1)
          : Colors.black26,
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(context),

      navBarStyle: NavBarStyle.style15,
      confineToSafeArea: true,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      hideNavigationBarWhenKeyboardAppears: true,

    );
  }
}
