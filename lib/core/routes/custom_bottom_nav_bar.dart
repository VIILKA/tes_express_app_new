import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tes_test_app/core/routes/route_constants.dart';
import 'package:tes_test_app/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
    final authState = context.watch<AuthBloc>().state;
    final isGuest = authState is AuthGuest;

    final displayedItems = isGuest
        ? navItems.where((item) => item.route != '/logistic').toList()
        : navItems;

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
        children: List.generate(displayedItems.length, (index) {
          final navItem = displayedItems[index];
          final isSelected = currentIndex == index;

          return GestureDetector(
            onTap: () => onTap(index),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  navItem.icon,
                  width: 30,
                  height: 30,
                  colorFilter: ColorFilter.mode(
                    isSelected
                        ? Colors.amber
                        : const Color.fromRGBO(153, 162, 173, 0.88),
                    BlendMode.srcIn,
                  ),
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
  final String icon;
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
  NavItem(
      icon: 'assets/images/home_icon.svg',
      label: 'Главное',
      route: RouteConstants.home),
  NavItem(
      icon: 'assets/images/market_icon.svg',
      label: 'Маркет',
      route: RouteConstants.market),
  NavItem(
      icon: 'assets/images/news_icon.svg',
      label: 'Новости',
      route: RouteConstants.news),
  NavItem(
      icon: 'assets/images/logistic_icon.svg',
      label: 'Логистика',
      route: RouteConstants.logistic),
  NavItem(
      icon: 'assets/images/profile_icon.svg',
      label: 'Профиль',
      route: RouteConstants.profile),
];
