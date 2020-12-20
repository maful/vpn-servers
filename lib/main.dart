import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:vpn_countries/routes/router.gr.dart';

Future<void> main() async {
  final sentryDsn = const String.fromEnvironment('sentryDsn');
  await SentryFlutter.init(
    (options) {
      options.dsn = sentryDsn;
    },
  );

  runApp(
    const ProviderScope(child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VPN',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      builder: ExtendedNavigator.builder<RouterApp>(
        router: RouterApp(),
        initialRoute: Routes.homeScreen,
      ),
    );
  }
}
