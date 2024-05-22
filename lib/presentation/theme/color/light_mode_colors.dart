part of "app_colors.dart";

class AppLightColor extends _AppColors {
  static AppLightColor? _instance;
  static AppLightColor get instance {
    _instance ??= AppLightColor._();
    return _instance!;
  }

  AppLightColor._()
      : super(
          background: const Color.fromARGB(255, 00, 00, 00),
          card: const Color.fromARGB(255, 25, 25, 25),
          danger: const Color.fromRGBO(239, 83, 80, 1),
          menu: const Color.fromARGB(255, 33, 33, 33),
          success: const Color.fromRGBO(102, 187, 106, 1),
          focus: const Color(0xFF198C53),
          unfocus: const Color.fromARGB(255, 183, 184, 185),
          text: const Color.fromRGBO(255, 255, 255, 1)
        );
}
