import 'package:flutter/material.dart';
import 'package:market_nest/utils/colors.dart';
import 'package:market_nest/view/cart_screen.dart';
import 'package:market_nest/view/home_screen.dart';

class BottomNavBar extends StatelessWidget {
  final String selectedIcon;

  const BottomNavBar({super.key, this.selectedIcon = 'Home'});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      decoration: BoxDecoration(
        border: Border(top: BorderSide(width: 1.0, color: greyColor)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          NavBar(
            icon: Icons.home,
            title: "Home",
            isSelected: selectedIcon == "Home",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
              );
            },
          ),
          NavBar(
            icon: Icons.store,
            title: "Shop",
            isSelected: selectedIcon == "Shop",
            onTap: () {
              // Navigation for Shop if needed
            },
          ),
          NavBar(
            icon: Icons.shopping_cart,
            title: "Cart",
            isSelected: selectedIcon == "Cart",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CartScreen()),
              );
            },
          ),
          NavBar(
            icon: Icons.person,
            title: "Profile",
            isSelected: selectedIcon == "Profile",
            onTap: () {
              // Navigation for Profile if needed
            },
          ),
        ],
      ),
    );
  }
}

class NavBar extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const NavBar({
    super.key,
    required this.icon,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: isSelected ? greenColor : greyColor, size: 25),
          const SizedBox(height: 2),
          Text(
            title,
            style: TextStyle(
              color: isSelected ? greenColor : greyColor,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
