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

  // Маршруты логистики
  static const String logisticDetails = 'logistic_details';

  // Маршруты профиля
  static const String carDetailsStatus = 'car_details_status';
  static const String stepsStatuses = 'steps_statuses';

  // Пример проверки для гостя
  static bool isGuestRestrictedRoute(String route) {
    return route.startsWith(logistic);
  }
}
