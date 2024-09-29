
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:my_flutter_app/main.dart';

void main() {
	group('Main App Initialization', () {
		testWidgets('should display LoginScreen on app start', (WidgetTester tester) async {
			await tester.pumpWidget(MyApp());

			expect(find.text('Login'), findsOneWidget);
			expect(find.byType(TextFormField), findsNWidgets(2));
			expect(find.widgetWithText(ElevatedButton, 'Login'), findsOneWidget);
		});
	});
}
