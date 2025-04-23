import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'custom_bottom_nav_bar.dart';
import 'route_constants.dart';

class MainPage extends StatefulWidget {
  final Widget child;

  const MainPage({
    super.key,
    required this.child,
  });

  // Статический ключ для доступа к состоянию MainPage из других виджетов
  static final GlobalKey<_MainPageState> mainPageKey =
      GlobalKey<_MainPageState>();

  // Статический метод для навигации и переключения вкладки
  static void navigateTo(BuildContext context, String route,
      {String? subRoute}) {
    final navigationRoute = subRoute != null ? '$route/$subRoute' : route;

    // Находим индекс вкладки по маршруту
    final index = navItems.indexWhere((item) => item.route == route);
    if (index != -1) {
      // Если нашли индекс, переключаем вкладку и выполняем навигацию
      mainPageKey.currentState?.setSelectedIndex(index);
      context.go(navigationRoute);
    } else {
      // Если индекс не найден, просто выполняем навигацию
      context.go(navigationRoute);
    }
  }

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  // Метод для обновления индекса из статического метода
  void setSelectedIndex(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // Достаём путь из нашего navItems
    final route = navItems[index].route;
    context.go(route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
