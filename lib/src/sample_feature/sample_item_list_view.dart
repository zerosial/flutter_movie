import 'package:flutter/material.dart';

import '../settings/settings_view.dart';
import 'sample_item.dart';
import 'sample_item_details_view.dart';

/// SampleItems 목록을 표시합니다.
class SampleItemListView extends StatelessWidget {
  const SampleItemListView({
    super.key,
    this.items = const [SampleItem(1), SampleItem(2), SampleItem(3)],
  });

  static const routeName = '/';

  final List<SampleItem> items;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sample Items'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // 설정 페이지로 이동합니다. 사용자가 앱을 종료한 후
              // 다시 돌아오면 탐색 스택이 복원됩니다.
              Navigator.restorablePushNamed(context, SettingsView.routeName);
            },
          ),
        ],
      ),

      // 많은 항목을 포함할 수 있는 목록을 다루려면 ListView.builder 생성자를 사용하는 것이 좋습니다.
      //
      // 기본 ListView 생성자와 달리, 모든 위젯을 미리 빌드하는 대신
      // ListView.builder 생성자는 스크롤될 때 위젯을 지연하여 빌드합니다.
      body: ListView.builder(
        // restorationId를 제공하면 사용자가 앱을 종료한 후 다시 돌아올 때
        // ListView의 스크롤 위치를 복원할 수 있습니다.
        restorationId: 'sampleItemListView',
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          final item = items[index];

          return ListTile(
              title: Text('SampleItem ${item.id}'),
              leading: const CircleAvatar(
                // Flutter 로고 이미지 자산을 표시합니다.
                foregroundImage: AssetImage('assets/images/flutter_logo.png'),
              ),
              onTap: () {
                // 세부 페이지로 이동합니다. 사용자가 앱을 종료한 후 다시 돌아오면
                // 탐색 스택이 복원됩니다.
                Navigator.restorablePushNamed(
                  context,
                  SampleItemDetailsView.routeName,
                );
              });
        },
      ),
    );
  }
}
