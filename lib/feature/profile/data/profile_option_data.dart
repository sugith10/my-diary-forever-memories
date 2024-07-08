import 'package:diary/core/util/asset_path/app_svg.dart';

import '../model/profile_option_model.dart';

class ProfileOptionData {
  static List<ProfileOptionModel> list = [
    ProfileOptionModel(
      icon: null,
      svg: AppSvg.darkMode,
      title: "Customization",
      callback: () {},
    ),
  ];
}
