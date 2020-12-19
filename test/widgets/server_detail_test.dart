import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vpn_countries/repositories/faker/fake_server_repository.dart';
import 'package:vpn_countries/repositories/server_repository.dart';
import 'package:vpn_countries/screens/server_detail_screen.dart';

Widget createServerDetailScreen(String code) => ProviderScope(
      overrides: [
        serverRepositoryProvider.overrideWithProvider(
          Provider<ServerRepository>((ref) => FakeServerRepository()),
        ),
      ],
      child: MaterialApp(
        home: ServerDetailScreen(code: code),
      ),
    );

void main() {
  group('Server Detail Page Widget Tests', () {
    testWidgets('Testing if Title is shows up', (WidgetTester tester) async {
      await tester.pumpWidget(createServerDetailScreen('AR'));

      expect(find.text('Argentina'), findsOneWidget);
    });

    testWidgets('Testing if Servers is shows up', (WidgetTester tester) async {
      await tester.pumpWidget(createServerDetailScreen('AR'));

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      await tester.pump();
      expect(find.byType(CircularProgressIndicator), findsNothing);
      expect(tester.widgetList(find.byType(ListTile)).length, equals(1));
    });
  });
}
