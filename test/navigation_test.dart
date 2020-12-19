import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mockito/mockito.dart';
import 'package:vpn_countries/repositories/faker/fake_server_repository.dart';
import 'package:vpn_countries/repositories/server_repository.dart';
import 'package:vpn_countries/routes/router.gr.dart';
import 'package:vpn_countries/screens/home_screen.dart';
import 'package:vpn_countries/screens/server_detail_screen.dart';

class MockNavigationObserver extends Mock implements NavigatorObserver {}

void main() {
  group('HomeScreen navigation tests', () {
    NavigatorObserver mockObserver;

    setUp(() {
      mockObserver = MockNavigationObserver();
    });

    Future<void> _buildHomeScreen(WidgetTester tester) async {
      await tester.pumpWidget(ProviderScope(
        overrides: [
          serverRepositoryProvider.overrideWithProvider(
            Provider<ServerRepository>((ref) => FakeServerRepository()),
          ),
        ],
        child: MaterialApp(
          home: HomeScreen(),
          builder: ExtendedNavigator.builder<RouterApp>(
            // This mocked observer will now receive all navigation events
            // that happend in the app.
            observers: [mockObserver],
            router: RouterApp(),
            initialRoute: Routes.homeScreen,
          ),
        ),
      ));

      // The tester.pumpWidget() call above just built our app widget
      // and triggered the pushObserver method on the mockObserver one.
      verify(mockObserver.didPush(any, any));
    }

    Future<void> _navigateToServerDetailScreen(WidgetTester tester) async {
      // Key widget that will tap
      final countryKey = Key('tap_country_ar');
      // Tap the widget should navigate to the Server Detail Screen.
      // By calling tester.pumpAndSettle(), we ensure that all animations
      // have completed before we continue further.
      await tester.tap(find.byKey(countryKey));
      await tester.pumpAndSettle();
    }

    testWidgets(
        'when tapping "country" button, should navigate to details page',
        (WidgetTester tester) async {
      await _buildHomeScreen(tester);
      // Ensure that state has ben changed
      await tester.pump();
      await _navigateToServerDetailScreen(tester);

      // By tapping the widget, we should have now navigated to the details
      // The didPush() method should have been called.
      verify(mockObserver.didPush(any, any));

      // And there should be a "ServerDetailScreen" present in the widget tree.
      final detailsFinder = find.byType(ServerDetailScreen);
      expect(detailsFinder, findsOneWidget);
      // Also there should be "Argentina" text in the widget tree.
      final titleFinder = find.text('Argentina');
      final strictMatch = find.descendant(
        of: detailsFinder,
        matching: titleFinder,
      );
      expect(strictMatch, findsOneWidget);
    });
  });
}
