import 'package:flutter/material.dart';

import 'settings_service.dart';

/// 사용자 설정을 읽고, 업데이트하거나 변경 사항을 들을 수 있도록
/// 여러 위젯들이 상호작용할 수 있는 클래스입니다.
class SettingsController with ChangeNotifier {
  SettingsController(this._settingsService);
  final SettingsService _settingsService;
  late ThemeMode _themeMode;
  ThemeMode get themeMode => _themeMode;

  /// SettingsService에서 사용자 설정을 불러옵니다. 로컬 데이터베이스나
  /// 인터넷에서 불러올 수 있습니다. 컨트롤러는 서비스에서 설정을 불러올 수 있다는 것만 알면 됩니다.
  Future<void> loadSettings() async {
    _themeMode = await _settingsService.themeMode();
    notifyListeners();
  }

  /// 사용자의 선택에 따라 ThemeMode를 업데이트하고 저장합니다.
  Future<void> updateThemeMode(ThemeMode? newThemeMode) async {
    if (newThemeMode == null) return;
    if (newThemeMode == _themeMode) return;
    _themeMode = newThemeMode;
    notifyListeners();
    await _settingsService.updateThemeMode(newThemeMode);
  }
}
