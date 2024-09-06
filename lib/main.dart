import 'package:flutter/material.dart';

import 'src/app.dart';
import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';

void main() async {
  // SettingsController를 설정하여 사용자 설정을 여러 Flutter 위젯에 연결합니다.
  final settingsController = SettingsController(SettingsService());

  // 앱이 처음 표시될 때 갑작스러운 테마 변경을 방지하기 위해
  // 스플래시 화면이 표시되는 동안 사용자의 선호 테마를 로드합니다.
  await settingsController.loadSettings();

  // 앱을 실행하고 SettingsController를 전달합니다. 앱은 SettingsController의 변경 사항을 수신하고,
  // 이를 SettingsView에 더 전달합니다.
  runApp(MyApp(settingsController: settingsController));
}
