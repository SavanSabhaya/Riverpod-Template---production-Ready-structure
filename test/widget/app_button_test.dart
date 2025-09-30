import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:boilerplate_rivepod_flutter/shared/widgets/app_button.dart';

void main() {
  group('AppButton Widget Tests', () {
    testWidgets('should render primary button correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppButton(
              text: 'Test Button',
              onPressed: null, // Disabled state
            ),
          ),
        ),
      );

      expect(find.text('Test Button'), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('should render different button types', (WidgetTester tester) async {
      // Test primary button
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppButton(
              text: 'Primary',
              type: AppButtonType.primary,
              onPressed: null,
            ),
          ),
        ),
      );

      expect(find.text('Primary'), findsOneWidget);

      // Test outline button
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppButton(
              text: 'Outline',
              type: AppButtonType.outline,
              onPressed: null,
            ),
          ),
        ),
      );

      expect(find.text('Outline'), findsOneWidget);

      // Test text button
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppButton(
              text: 'Text',
              type: AppButtonType.text,
              onPressed: null,
            ),
          ),
        ),
      );

      expect(find.text('Text'), findsOneWidget);
    });

    testWidgets('should render different button sizes', (WidgetTester tester) async {
      // Test small button
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppButton(
              text: 'Small',
              size: AppButtonSize.small,
              onPressed: null,
            ),
          ),
        ),
      );

      expect(find.text('Small'), findsOneWidget);

      // Test large button
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppButton(
              text: 'Large',
              size: AppButtonSize.large,
              onPressed: null,
            ),
          ),
        ),
      );

      expect(find.text('Large'), findsOneWidget);
    });

    testWidgets('should show loading state', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppButton(
              text: 'Loading Button',
              isLoading: true,
              onPressed: null,
            ),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('should handle tap events', (WidgetTester tester) async {
      var tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppButton(
              text: 'Tap Me',
              onPressed: () {
                tapped = true;
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('Tap Me'));
      await tester.pump();

      expect(tapped, true);
    });

    testWidgets('should render with leading and trailing icons', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppButton(
              text: 'Icon Button',
              leadingIcon: Icon(Icons.star),
              trailingIcon: Icon(Icons.arrow_forward),
              onPressed: null,
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.star), findsOneWidget);
      expect(find.byIcon(Icons.arrow_forward), findsOneWidget);
      expect(find.text('Icon Button'), findsOneWidget);
    });

    testWidgets('should be disabled when onPressed is null', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppButton(
              text: 'Disabled Button',
              onPressed: null,
            ),
          ),
        ),
      );

      final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
      expect(button.onPressed, null);
    });

    testWidgets('should be disabled when isDisabled is true', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppButton(
              text: 'Disabled Button',
              isDisabled: true,
              onPressed: () {
                // This should not be called
              },
            ),
          ),
        ),
      );

      final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
      expect(button.onPressed, null);
    });
  });

  group('AppButton Accessibility Tests', () {
    testWidgets('should have proper semantics', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppButton(
              text: 'Accessible Button',
              onPressed: null,
            ),
          ),
        ),
      );

      expect(find.bySemanticsLabel('Accessible Button'), findsOneWidget);
    });

    testWidgets('should support font scaling', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MediaQuery(
              data: const MediaQueryData(textScaler: TextScaler.linear(2.0)),
              child: const AppButton(
                text: 'Scaled Button',
                onPressed: null,
              ),
            ),
          ),
        ),
      );

      expect(find.text('Scaled Button'), findsOneWidget);
    });
  });

  group('AppButton Theme Integration Tests', () {
    testWidgets('should use theme colors', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            primaryColor: Colors.red,
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
            ),
          ),
          home: const Scaffold(
            body: AppButton(
              text: 'Themed Button',
              onPressed: null,
            ),
          ),
        ),
      );

      expect(find.text('Themed Button'), findsOneWidget);
    });
  });
}
