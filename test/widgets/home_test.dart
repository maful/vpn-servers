import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vpn_countries/repositories/faker/fake_server_repository.dart';
import 'package:vpn_countries/repositories/server_repository.dart';
import 'package:vpn_countries/screens/home_screen.dart';

Widget createHomeScreen() => ProviderScope(
      overrides: [
        serverRepositoryProvider.overrideWithProvider(
          Provider<ServerRepository>((ref) => FakeServerRepository()),
        ),
      ],
      child: MaterialApp(
        home: HomeScreen(),
      ),
    );

void main() {
  group('Home Page Widget Tests', () {
    testWidgets('Testing if Title is shows up', (WidgetTester tester) async {
      await tester.pumpWidget(createHomeScreen());
      expect(find.text('VPN Countries'), findsOneWidget);
    });

    testWidgets('Testing if CircularProgressIndicator is shows up',
        (WidgetTester tester) async {
      await tester.pumpWidget(createHomeScreen());

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      await tester.pump();
      expect(find.byType(CircularProgressIndicator), findsNothing);
    });

    testWidgets('Testing if ListView is shows up', (WidgetTester tester) async {
      await tester.pumpWidget(createHomeScreen());

      expect(find.byType(ListView), findsNothing);
      await tester.pump();
      expect(find.byType(ListView), findsOneWidget);
      expect(tester.widgetList(find.byType(ListTile)).length, 2);
    });
  });
}
