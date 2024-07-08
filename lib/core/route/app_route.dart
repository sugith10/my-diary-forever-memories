part of 'app_route_package.dart';

class AppRoute {
  AppRoute._();
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.initial:
        return noMovement(const SplashPage());
      case RouteName.welcome:
        return noMovement(const WelcomePage());
      case RouteName.home:
        return noMovement(const MainNavigationMenu());
    }

    return noMovement(const ErrorPage());
  }
}
