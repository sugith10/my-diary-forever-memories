import 'package:diary/core/model/notification_model.dart';
import 'package:diary/feature/customization/model/theme_model.dart';

class ThemeModeNotificationUtil {
  ThemeModeNotificationUtil._();
  static NotificationModel show(ThemeModel themeModel) {
    if (themeModel == ThemeModel.day) {
      return NotificationModel(
          title: "It's now Day Mode",
          description: "Brighten your day with My Diary!");
    } else {
      return NotificationModel(
          title: "It's now Night Mode",
          description: "Relax your eyes with My Diary!");
    }
  }
}
