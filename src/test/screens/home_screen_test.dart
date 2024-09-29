
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:com.example.my_flutter_app/screens/home_screen.dart';
import 'package:com.example.my_flutter_app/cubits/home_cubit.dart';

class MockHomeCubit extends MockCubit<void> implements HomeCubit {}

void main() {
	group('HomeScreen Widget Tests', () {
		testWidgets('should display a logout button', (WidgetTester tester) async {
			await tester.pumpWidget(MaterialApp(home: HomeScreen()));

			expect(find.byType(ElevatedButton), findsOneWidget);
			expect(find.text('Logout'), findsOneWidget);
		});

		testWidgets('should call logout method when logout button is pressed', (WidgetTester tester) async {
			final mockHomeCubit = MockHomeCubit();
			when(() => mockHomeCubit.logout()).thenReturn(null);

			await tester.pumpWidget(
				MaterialApp(
					home: BlocProvider<HomeCubit>(
						create: (_) => mockHomeCubit,
						child: HomeScreen(),
					),
				),
			);

			await tester.tap(find.byType(ElevatedButton));
			await tester.pump();

			verify(() => mockHomeCubit.logout()).called(1);
		});
	});
}
