import 'package:ecommerce_app/screens/cart_page.dart';
import 'package:ecommerce_app/screens/home_page.dart';
import 'package:ecommerce_app/screens/search_page.dart';
import 'package:ecommerce_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        onPageChanged: (value) {
          setState(() {});
        },
        controller: _pageController,
        children: const [
          HomePage(),
          SearchPage(),
          CartPage(),
          Center(
            child: Text('Profile'),
          ),
        ],
      ),
      extendBody: true,
      bottomNavigationBar: GlassWidget(
        child: GNav(
          selectedIndex: _pageController.hasClients
              ? _pageController.page?.round() ?? 0
              : 0,
          onTabChange: (index) {
            _pageController.animateToPage(index,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut);
          },
          rippleColor: colorScheme(context).primary.withOpacity(0.2),
          hoverColor: colorScheme(context).primary.withOpacity(0.1),
          haptic: true,
          tabBorderRadius: 30,
          tabActiveBorder:
              Border.all(color: colorScheme(context).onPrimary, width: 1),
          // tabBorder: Border.all(color: Colors.grey, width: 1),
          // tabShadow: [
          //   BoxShadow(color: Colors.grey.withOpacity(0.5), blurRadius: 8)
          // ],
          curve: Curves.easeInOut,
          duration: const Duration(milliseconds: 300),
          gap: 8,
          color: Colors.grey[800],
          activeColor: colorScheme(context).primary,
          iconSize: 24,
          tabBackgroundColor: colorScheme(context).primary.withOpacity(0.1),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          tabs: const [
            GButton(
              icon: Icons.home_rounded,
              text: 'Home',
            ),
            GButton(
              icon: Icons.search_rounded,
              text: 'Search',
            ),
            GButton(
              icon: Icons.shopping_cart_rounded,
              text: 'Cart',
            ),
            GButton(
              icon: Icons.person_rounded,
              text: 'Profile',
            )
          ],
        ),
      ),
    );
  }
}
