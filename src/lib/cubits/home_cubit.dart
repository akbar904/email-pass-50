
import 'package:flutter_bloc/flutter_bloc.dart';

// Define the states
abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoggedOut extends HomeState {}

// Define the Cubit
class HomeCubit extends Cubit<HomeState> {
	HomeCubit() : super(HomeInitial());

	void logout() {
		emit(HomeLoading());
		// Simulate a delay for the logout process
		Future.delayed(const Duration(seconds: 1), () {
			emit(HomeLoggedOut());
		});
	}
}
