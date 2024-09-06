import 'package:flutter/material.dart';

import 'settings_controller.dart';

/// 사용자가 사용자 정의할 수 있는 다양한 설정을 표시합니다.
///
/// 사용자가 설정을 변경하면 SettingsController가 업데이트되고
/// SettingsController를 듣는 위젯들이 다시 빌드됩니다.
class SettingsView extends StatelessWidget {
  const SettingsView({super.key, required this.controller});

  static const routeName = '/settings';

  final SettingsController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        // SettingsController를 테마 선택 DropdownButton에 연결합니다.
        //
        // 사용자가 드롭다운 목록에서 테마를 선택하면
        // SettingsController가 업데이트되어 MaterialApp이 다시 빌드됩니다.
        child: DropdownButton<ThemeMode>(
          // controller에서 선택된 themeMode를 읽어옵니다.
          value: controller.themeMode,
          // 사용자가 테마를 선택할 때마다 updateThemeMode 메서드를 호출합니다.
          onChanged: controller.updateThemeMode,
          items: const [
            DropdownMenuItem(
              value: ThemeMode.system,
              child: Text('System Theme'),
            ),
            DropdownMenuItem(
              value: ThemeMode.light,
              child: Text('Light Theme'),
            ),
            DropdownMenuItem(
              value: ThemeMode.dark,
              child: Text('Dark Theme'),
            )
          ],
        ),
      ),
    );
  }
}
