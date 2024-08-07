part of "app_colors.dart";

class AppDarkColor extends _AppColors {
  static AppDarkColor? _instance;
  static AppDarkColor get instance {
    _instance ??= AppDarkColor._();
    return _instance!;
  }

  AppDarkColor._()
      : super(
          background: const Color.fromARGB(255, 00, 00, 00),
          card: const Color.fromARGB(255, 25, 25, 25),
          danger: const Color.fromRGBO(239, 83, 80, 1),
          menu: const Color.fromARGB(255, 33, 33, 33),
          success: const Color.fromRGBO(76, 175, 80, 1),
          focus: const Color(0xFF198C53),
          unfocus: const Color.fromARGB(255, 183, 184, 185),
          primaryText: const Color.fromRGBO(255, 255, 255, 1),
          secondaryText: Colors.grey,
          pageOne: Colors.teal,
          pageTwo: Colors.pink,
          pageThree: Colors.orange,
          pageFour: Colors.purple,
          elevatedButton: const Color(0xFF198C53),

        );
}
