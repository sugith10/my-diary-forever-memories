part of "app_colors.dart";

class AppLightColor extends _AppColors {
  static AppLightColor? _instance;
  static AppLightColor get instance {
    _instance ??= AppLightColor._();
    return _instance!;
  }

  AppLightColor._()
      : super(
          background: const Color.fromARGB(255, 255, 255, 255),
          card: const Color.fromRGBO(255, 255, 255, 1),
          danger: const  Color.fromRGBO(244, 67, 54, 1),
          menu: const Color.fromARGB(255, 33, 33, 33),
          success: const Color.fromRGBO(102, 187, 106, 1),
          
          focus: const Color(0xFF198C53),
          unfocus: const Color.fromARGB(255, 183, 184, 185),
          primaryText: const Color.fromARGB(255, 0, 0, 0),
          secondaryText: Colors.grey,
          pageOne: Colors.purple,
          pageTwo: Colors.pink,
          pageThree: Colors.orange,
          pageFour: Colors.teal,
          elevatedButton:const Color(0xFF198C53)
        );
}
