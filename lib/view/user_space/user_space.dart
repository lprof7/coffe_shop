import 'package:coffee_shop_app/view/user_space/pages/basket/basket_screen.dart';
import 'package:coffee_shop_app/view/user_space/pages/favorit/favorit_screen.dart';
import 'package:coffee_shop_app/view/user_space/pages/home_page/home_page_screen.dart';
import 'package:coffee_shop_app/view/user_space/pages/orders/orders_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class User_space_screen extends StatelessWidget {
  User_space_screen({super.key});

  // Improve page ordering logically
  RxInt _currentIndex = 0.obs;

  // Logical page order: Home -> Orders -> Basket -> Favorites
  List<Widget> pages = [
    Home_screen(),
    Orders_screen(),
    Basket_screen(),
    Favorite_screen_page(),
  ];

  // Improve navigation bar options with clear labels
  List<Map<String, dynamic>> navigationItems = [
    {
      "active_icon": Icons.home_rounded,
      "non_active_icon": Icons.home_outlined,
      "label": "Home",
    },
    {
      "active_icon": Icons.receipt_long_rounded,
      "non_active_icon": Icons.receipt_long_outlined,
      "label": "Orders",
    },
    {
      "active_icon": Icons.shopping_basket_rounded,
      "non_active_icon": Icons.shopping_basket_outlined,
      "label": "Basket",
    },
    {
      "active_icon": Icons.favorite_rounded,
      "non_active_icon": Icons.favorite_outline,
      "label": "Favorites",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 39, 39, 39),
      // Add custom AppBar
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 39, 39, 39),
        elevation: 0,
        title: Obx(
          () => Text(
            _getPageTitle(_currentIndex.value),
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Cairo',
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        actions: [
          // Add notifications button
          IconButton(
            icon: Icon(Icons.notifications_outlined, color: Colors.white),
            onPressed: () {
              Get.snackbar(
                'Notifications',
                'No new notifications',
                backgroundColor: Color.fromARGB(255, 209, 121, 66),
                colorText: Colors.white,
              );
            },
          ),
          // Add user profile image
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: CircleAvatar(
              radius: 16,
              backgroundImage: AssetImage('images/user.jpg'),
            ),
          ),
        ],
      ),
      // Add animation for transitions
      body: Obx(
        () => AnimatedSwitcher(
          duration: Duration(milliseconds: 300),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return SlideTransition(
              position: Tween<Offset>(begin: Offset(0.1, 0), end: Offset.zero)
                  .animate(
                    CurvedAnimation(parent: animation, curve: Curves.easeInOut),
                  ),
              child: FadeTransition(opacity: animation, child: child),
            );
          },
          child: pages[_currentIndex.value],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              offset: Offset(0, -5),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex.value,
          onTap: (index) {
            _currentIndex.value = index;
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: Color.fromARGB(255, 39, 39, 39),
          selectedItemColor: Color.fromARGB(255, 209, 121, 66),
          unselectedItemColor: Colors.grey,
          selectedLabelStyle: TextStyle(
            fontFamily: 'Cairo',
            fontWeight: FontWeight.w600,
          ),
          unselectedLabelStyle: TextStyle(fontFamily: 'Cairo'),
          items: navigationItems.map((item) {
            return BottomNavigationBarItem(
              icon: Icon(item["non_active_icon"]),
              activeIcon: Icon(item["active_icon"]),
              label: item["label"],
            );
          }).toList(),
        ),
      ),
    );
  }

  String _getPageTitle(int index) {
    switch (index) {
      case 0:
        return "Home";
      case 1:
        return "Orders";
      case 2:
        return "Basket";
      case 3:
        return "Favorites";
      default:
        return "Coffee Shop";
    }
  }
}
