import 'package:diary/feature/customization/model/theme_model.dart';
import '../data/theme_data.dart';

class AppThemeRepo {
  final AppThemeData _appThemeData;

  AppThemeRepo(this._appThemeData);

  Future<ThemeModel> getThemePreference() async {
    try {
      return await _appThemeData.getThemePreference();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> setThemePreference(ThemeModel themeModel) async {
    try {
      await _appThemeData.setThemePreference(themeModel);
    } catch (e) {
      rethrow;
    }
  }
}
