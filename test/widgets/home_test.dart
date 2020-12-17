import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vpn_countries/screens/home_screen.dart';

Widget createHomeScreen() => ProviderScope(
      child: MaterialApp(
        home: HomeScreen(),
      ),
    );

void main() {
  testWidgets('update', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(home: HomeScreen()),
      ),
    );
    
    await tester.pump(Duration(seconds: 10));
    expect(find.text('VPN Countries'), findsOneWidget);
  });
}
