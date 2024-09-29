
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_flutter_app/models/user.dart';

// Define the states
abstract class LoginState extends Equatable {
	@override
	List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginFailure extends LoginState {
	final String error;

	LoginFailure(this.error);

	@override
	List<Object> get props => [error];
}

// Define the cubit
class LoginCubit extends Cubit<LoginState> {
	LoginCubit() : super(LoginInitial());

	void login(String email, String password) async {
		try {
			emit(LoginLoading());
			// Mocking network call delay
			await Future.delayed(Duration(milliseconds: 100));

			// Mocking successful login
			if (email == 'test@test.com' && password == 'password') {
				emit(LoginSuccess());
			} else {
				emit(LoginFailure('Login failed'));
			}
		} catch (e) {
			emit(LoginFailure(e.toString()));
		}
	}
}
