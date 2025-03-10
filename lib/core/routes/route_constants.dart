class RouteConstants {
  // Основные маршруты
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/';
  static const String market = '/market';
  static const String news = '/news';
  static const String logistic = '/logistic';
  static const String profile = '/profile';
  static const String notRegisteredUser = '/not_registered_user';

  // Маршруты логистики
  static const String logisticDetails = 'logistic_details';
  static const String logisticWithMap = '$logistic/$logisticDetails';

  // Маршруты профиля
  static const String carDetailsStatus = 'car_details_status';
  static const String stepsStatuses = 'steps_statuses';

  // Полные пути для вложенных маршрутов профиля
  static const String profileCarDetails = '$profile/$carDetailsStatus';
  static const String profileStepsStatuses =
      '$profileCarDetails/$stepsStatuses';

  // Вспомогательный метод для проверки авторизационных маршрутов
  static bool isAuthRoute(String route) {
    return route == login || route == register;
  }

  // Вспомогательный метод для проверки защищенных маршрутов
  static bool isProtectedRoute(String route) {
    return !isAuthRoute(route);
  }

  static bool isGuestRestrictedRoute(String route) {
    return route.startsWith(logistic);
  }

  static bool isGuestAllowedRoute(String route) {
    return route == home ||
        route == market ||
        route == news ||
        route == notRegisteredUser;
  }
}
