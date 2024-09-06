import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_movie/src/screens/main_screen.dart';
import 'package:flutter_movie/src/screens/movie_detail_screen.dart';
import 'settings/settings_controller.dart';
import 'settings/settings_view.dart';

/// 애플리케이션을 구성하는 위젯입니다.
class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.settingsController,
  });

  final SettingsController settingsController;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: settingsController,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          restorationScopeId: 'app',

          // 생성된 AppLocalizations를 MaterialApp에 제공합니다.
          // 이를 통해 하위 위젯들이 사용자의 로케일에 따라 올바른 번역을 표시할 수 있습니다.
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', ''), // 영어, 국가 코드 없음
          ],

          // AppLocalizations를 사용하여 사용자의 로케일에 따라
          // 올바른 애플리케이션 제목을 구성합니다.
          // appTitle은 로컬라이제이션 디렉토리에서 찾을 수 있는 .arb 파일에 정의되어 있습니다.
          onGenerateTitle: (BuildContext context) =>
              AppLocalizations.of(context)!.appTitle,
          theme: ThemeData(),
          darkTheme: ThemeData.dark(),
          themeMode: settingsController.themeMode,

          // Flutter 웹 URL 탐색 및 딥 링크를 지원하기 위해
          // 네임드 라우트를 처리하는 함수를 정의합니다.
          onGenerateRoute: (RouteSettings routeSettings) {
            return MaterialPageRoute<void>(
              settings: routeSettings,
              builder: (BuildContext context) {
                switch (routeSettings.name) {
                  case SettingsView.routeName:
                    return SettingsView(controller: settingsController);

                  // 영화 세부 정보 페이지 라우트
                  case '/movie-detail':
                    // arguments로 movieId와 heroTag를 모두 전달하도록 수정
                    final args =
                        routeSettings.arguments as Map<String, dynamic>;
                    return MovieDetailPage(
                      movieId: args['movieId'] as int,
                      heroTag: args['heroTag'] as String, // heroTag 추가
                    );

                  // 메인 페이지 기본 경로
                  default:
                    return const MainPage();
                }
              },
            );
          },
        );
      },
    );
  }
}
