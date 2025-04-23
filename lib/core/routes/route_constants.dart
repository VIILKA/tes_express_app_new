class RouteConstants {
  // Пути авторизации
  static const String login = '/login';
  static const String register = '/register';

  // Splash отдельным путём
  static const String splash = '/';

  // Основные рабочие пути
  static const String home = '/home';
  static const String market = '/market';
  static const String news = '/news';
  static const String logistic = '/logistic';
  static const String profile = '/profile';
  static const String notRegisteredUser = '/not_registered_user';

  // Маршруты маркета
  static const String cars = 'cars';
  static const String carDetails = 'car_details';

  // Маршруты логистики
  static const String logisticDetails = 'logistic_details';

  // Маршруты профиля
  static const String carDetailsStatus = 'car_details_status';
  static const String stepsStatuses = 'steps_statuses';
  static const String orderHistory = 'order_history';

  // Пример проверки для гостя
  static bool isGuestRestrictedRoute(String route) {
    return route.startsWith(logistic);
  }
}
