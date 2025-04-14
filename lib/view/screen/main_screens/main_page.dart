// import 'package:flutter/material.dart';
// import '../../../constant/colors.dart';
// import '../../../constant/main_screen/main_screen_data.dart';
// import '../../widgets/main_page_widgets/tap_button.dart';
//
// class MainPage extends StatefulWidget {
//   const MainPage({super.key});
//
//   @override
//   State<MainPage> createState() => _MainPageState();
// }
//
// class _MainPageState extends State<MainPage> {
//   int selectedTab = 0;
//   final PageController _pageController = PageController();
//
//   void _onTabSelected(int index) {
//     setState(() {
//       selectedTab = index;
//     });
//     _pageController.animateToPage(
//       index,
//       duration: const Duration(milliseconds: 300),
//       curve: Curves.easeInOut,
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//
//       //so the floatingActionButton stays contestant
//       backgroundColor: Colors.white,
//       body: PageView(
//
//         controller: _pageController,
//         physics:  NeverScrollableScrollPhysics(), // the animation of the sliding
//         onPageChanged: (index) {
//           setState(() => selectedTab = index);
//         },
//         children: pages,
//       ),
//       floatingActionButtonLocation: // the middle cart button
//           FloatingActionButtonLocation.miniCenterDocked,
//       floatingActionButton: SizedBox(
//         width: 60,
//         height: 60,
//         child: FloatingActionButton(
//           onPressed: () => _onTabSelected(2),
//           shape: const CircleBorder(),
//           backgroundColor:
//               selectedTab == 2
//                   ? AppColors.primaryColor
//                   : AppColors.primaryColor,
//           child: Image.asset(
//             bottomNavImages[2], // Cart icon only
//             width: 30,
//             height: 30,
//             color: Colors.white,
//           ),
//         ),
//       ),
//       bottomNavigationBar: BottomAppBar(
//         color: const Color.fromARGB(255, 219, 244, 209),
//         shape: const CircularNotchedRectangle(),
//         // surfaceTintColor: Colors.white,
//         // shadowColor: Colors.black,
//         elevation: 1,
//         notchMargin: 12,
//         height: 64,
//
//         child: SafeArea(
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               TabButton(
//                 // the button
//                 title: bottomNavLabels[0],
//                 icon: bottomNavImages[0],
//                 onTap: () => _onTabSelected(0),
//                 isSelected: selectedTab == 0,
//               ),
//               TabButton(
//                 title: bottomNavLabels[1],
//                 icon: bottomNavImages[1],
//                 onTap: () => _onTabSelected(1),
//                 isSelected: selectedTab == 1,
//               ),
//               const SizedBox(width: 40, height: 40),
//               // Space for floating button
//               TabButton(
//                 title: bottomNavLabels[3],
//                 icon: bottomNavImages[3],
//                 onTap: () => _onTabSelected(3),
//                 isSelected: selectedTab == 3,
//               ),
//               TabButton(
//                 title: bottomNavLabels[4],
//                 icon: bottomNavImages[4],
//                 onTap: () => _onTabSelected(4),
//                 isSelected: selectedTab == 4,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:foodtek/core/responseve.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import '../../../constant/colors.dart';
import '../../../constant/main_screen/main_screen_data.dart';

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

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return List.generate(5, (index) {
      bool isCart = index == 2; // Assuming cart is at index 2
      return PersistentBottomNavBarItem(
        icon: isCart
            ? Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            shape: BoxShape.circle,
          ),
          child: Image.asset(
            bottomNavImages[index],
            width: 30,
            height: 30,
            color: Colors.white,
          ),
        )
            : Image.asset(
          bottomNavImages[index],
          width: responsiveHeight(context, 24),
          height: responsiveWidth(context, 24),
          color: index == _controller.index
              ? AppColors.primaryColor
              : Colors.grey,
        ),
        title: bottomNavLabels[index],
        textStyle: TextStyle(
          color: index == _controller.index
              ? AppColors.primaryColor
              : Colors.grey,
        ),
        activeColorPrimary: AppColors.primaryColor,
        inactiveColorPrimary: Colors.grey,
      );
    });
  }


  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      navBarHeight: 60,
      backgroundColor: Colors.green.shade100,
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),

      navBarStyle: NavBarStyle.style15,


      //backgroundColor: Colors.white,
      confineToSafeArea: true,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,

      //hideNavigationBarWhenKeyboardAppears:true ,
      // decoration: NavBarDecoration(
      //   borderRadius: BorderRadius.circular(20.0),
      // ),
    );
  }
}
