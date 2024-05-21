import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:timers/models/workout_timer.dart';
import 'package:timers/screens/main_timer.dart';
import 'package:timers/screens/overview/overview_screen.dart';
import 'package:timers/utils/app_theme.dart';
import 'package:timers/utils/size_config.dart';

void main() {
  runApp(const MyApp());
  _prepareLicenses();
}

void _prepareLicenses() {
  LicenseRegistry.addLicense(() => Stream<LicenseEntry>.value(
        const LicenseEntryWithLineBreaks(
            <String>['confetti animation by sarahw1'], '''
 CCBY / Link to the community rive animation given kindly by user sarahw1: https://rive.app/community/files/2959-6204-confetti-mobile/'''),
      ));
}

late SizeConfig sizeConfig;

final GoRouter _router = GoRouter(routes: <RouteBase>[
  GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return OverviewScreen();
      },
      routes: <RouteBase>[
        GoRoute(
            path: 'timer/:id',
            builder: (BuildContext context, GoRouterState state) {
              return MainTimer(
                  workoutId: int.parse(state.pathParameters['id']!));
            })
      ])
]);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    sizeConfig = SizeConfig();
    sizeConfig.init(context);
    return MaterialApp.router(
      routerConfig: _router,
      title: 'Flutter Demo',
      theme: AppTheme.themeData,
    );
  }
}
