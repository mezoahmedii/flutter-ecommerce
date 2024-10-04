import 'package:flutter/material.dart';

class CustomNavigationBar extends StatelessWidget {
  final int index;

  const CustomNavigationBar({super.key, this.index = 0});

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      destinations: [
        NavigationDestination(icon: Icon(Icons.home_rounded), label: "Home"),
        NavigationDestination(
            icon: Icon(Icons.shopping_cart_rounded), label: "Cart"),
        NavigationDestination(
            icon: Icon(Icons.account_circle_rounded), label: "Account"),
      ],
      selectedIndex: index,
      onDestinationSelected: (i) {
        if (i == 0) {
          Navigator.popAndPushNamed(context, "/homeScreen");
        } else if (i == 1) {
          Navigator.popAndPushNamed(context, "/cartScreen");
        } else {
          Navigator.popAndPushNamed(context, "/accountScreen");
        }
      },
    );
  }
}
