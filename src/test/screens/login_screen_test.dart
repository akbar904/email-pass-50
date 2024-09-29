
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_flutter_app/screens/login_screen.dart';

class MockLoginCubit extends MockCubit<LoginState> implements LoginCubit {}

void main() {
	group('LoginScreen Widget Tests', () {
		testWidgets('should display email and password text fields', (WidgetTester tester) async {
			await tester.pumpWidget(MaterialApp(home: LoginScreen()));

			expect(find.byType(TextFormField), findsNWidgets(2));
			expect(find.text('Email'), findsOneWidget);
			expect(find.text('Password'), findsOneWidget);
		});

		testWidgets('should display login button', (WidgetTester tester) async {
			await tester.pumpWidget(MaterialApp(home: LoginScreen()));

			expect(find.text('Login'), findsOneWidget);
			expect(find.byType(ElevatedButton), findsOneWidget);
		});
	});

	group('LoginCubit Tests', () {
		late MockLoginCubit mockLoginCubit;

		setUp(() {
			mockLoginCubit = MockLoginCubit();
		});

		blocTest<MockLoginCubit, LoginState>(
			'should emit [LoginLoading, LoginSuccess] when login is successful',
			build: () => mockLoginCubit,
			act: (cubit) => cubit.login('test@example.com', 'password123'),
			expect: () => [LoginLoading(), LoginSuccess()],
		);

		blocTest<MockLoginCubit, LoginState>(
			'should emit [LoginLoading, LoginFailure] when login fails',
			build: () => mockLoginCubit,
			act: (cubit) => cubit.login('test@example.com', 'wrongpassword'),
			expect: () => [LoginLoading(), LoginFailure('Invalid credentials')],
		);
	});
}
