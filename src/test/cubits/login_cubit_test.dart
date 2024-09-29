
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_flutter_app/cubits/login_cubit.dart';

class MockLoginCubit extends MockCubit<LoginState> implements LoginCubit {}

void main() {
	group('LoginCubit', () {
		late LoginCubit loginCubit;

		setUp(() {
			loginCubit = MockLoginCubit();
		});

		blocTest<LoginCubit, LoginState>(
			'Initial state is LoginInitial',
			build: () => loginCubit,
			verify: (cubit) => expect(cubit.state, equals(LoginInitial())),
		);

		blocTest<LoginCubit, LoginState>(
			'Emits [LoginLoading, LoginSuccess] when login is successful',
			build: () => loginCubit,
			act: (cubit) {
				when(() => cubit.login(any(), any())).thenAnswer((_) async {
					cubit.emit(LoginLoading());
					await Future.delayed(Duration(milliseconds: 100));
					cubit.emit(LoginSuccess());
				});
				cubit.login('test@test.com', 'password');
			},
			expect: () => [LoginLoading(), LoginSuccess()],
		);

		blocTest<LoginCubit, LoginState>(
			'Emits [LoginLoading, LoginFailure] when login fails',
			build: () => loginCubit,
			act: (cubit) {
				when(() => cubit.login(any(), any())).thenAnswer((_) async {
					cubit.emit(LoginLoading());
					await Future.delayed(Duration(milliseconds: 100));
					cubit.emit(LoginFailure('Login failed'));
				});
				cubit.login('test@test.com', 'wrongpassword');
			},
			expect: () => [LoginLoading(), LoginFailure('Login failed')],
		);
	});
}
