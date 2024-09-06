import 'package:flutter/material.dart';

import 'settings_service.dart';

/// 사용자 설정을 읽고, 업데이트하거나 변경 사항을 들을 수 있도록
/// 여러 위젯들이 상호작용할 수 있는 클래스입니다.
///
/// 컨트롤러는 데이터 서비스를 Flutter 위젯에 연결하는 역할을 합니다.
/// SettingsController는 SettingsService를 사용하여 사용자 설정을 저장하고 불러옵니다.
class SettingsController with ChangeNotifier {
  SettingsController(this._settingsService);

  // SettingsService를 private 변수로 만들어 직접 사용되지 않도록 합니다.
  final SettingsService _settingsService;

  // ThemeMode를 private 변수로 만들어, SettingsService와 함께
  // 변경 사항을 영구 저장하지 않고 직접 업데이트되지 않도록 합니다.
  late ThemeMode _themeMode;

  // 위젯이 사용자의 선호 ThemeMode를 읽을 수 있도록 허용합니다.
  ThemeMode get themeMode => _themeMode;

  /// SettingsService에서 사용자 설정을 불러옵니다. 로컬 데이터베이스나
  /// 인터넷에서 불러올 수 있습니다. 컨트롤러는 서비스에서 설정을 불러올 수 있다는 것만 알면 됩니다.
  Future<void> loadSettings() async {
    _themeMode = await _settingsService.themeMode();

    // 중요! 변경 사항이 발생했음을 리스너들에게 알립니다.
    notifyListeners();
  }

  /// 사용자의 선택에 따라 ThemeMode를 업데이트하고 저장합니다.
  Future<void> updateThemeMode(ThemeMode? newThemeMode) async {
    if (newThemeMode == null) return;

    // 새로운 ThemeMode와 기존 ThemeMode가 동일하면 작업을 수행하지 않습니다.
    if (newThemeMode == _themeMode) return;

    // 그렇지 않으면 새 ThemeMode를 메모리에 저장합니다.
    _themeMode = newThemeMode;

    // 중요! 변경 사항이 발생했음을 리스너들에게 알립니다.
    notifyListeners();

    // SettingService를 사용하여 변경 사항을 로컬 데이터베이스나 인터넷에 저장합니다.
    await _settingsService.updateThemeMode(newThemeMode);
  }
}
