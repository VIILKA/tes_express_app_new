import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 85,
      decoration: const BoxDecoration(
        color: Color.fromRGBO(253, 253, 253, 0.88),
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(6, 0, 0, 0),
            blurRadius: 8,
            offset: Offset(0, -1),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(navItems.length, (index) {
          final navItem = navItems[index];
          final isSelected = currentIndex == index;

          return GestureDetector(
            onTap: () => onTap(index),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  size: 30,
                  navItem.icon,
                  color: isSelected
                      ? Colors.amber
                      : const Color.fromRGBO(153, 162, 173, 0.88),
                ),
                const SizedBox(height: 2),
                Text(
                  navItem.label,
                  style: TextStyle(
                    color: isSelected ? Colors.amber : Colors.grey,
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

class NavItem {
  final IconData icon;
  final String label;
  final String route;

  const NavItem({
    required this.icon,
    required this.label,
    required this.route,
  });
}

// Список всех вкладок приложения:
const List<NavItem> navItems = [
  NavItem(icon: Icons.home_outlined, label: 'Главное', route: '/'),
  NavItem(icon: Icons.store_outlined, label: 'Маркет', route: '/market'),
  NavItem(icon: Icons.newspaper_outlined, label: 'Новости', route: '/news'),
  NavItem(icon: Icons.map_outlined, label: 'Логистика', route: '/logistic'),
  NavItem(icon: Icons.person_2_outlined, label: 'Профиль', route: '/profile'),
];
