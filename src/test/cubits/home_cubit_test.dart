
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_flutter_app/cubits/home_cubit.dart';

// Mock dependencies if any, here we assume there are none directly used in home_cubit.dart

void main() {
	group('HomeCubit', () {
		late HomeCubit homeCubit;

		setUp(() {
			homeCubit = HomeCubit();
		});

		tearDown(() {
			homeCubit.close();
		});

		test('initial state is HomeInitial', () {
			expect(homeCubit.state, equals(HomeInitial()));
		});

		blocTest<HomeCubit, HomeState>(
			'emits [HomeLoading, HomeLoggedOut] when logout is called',
			build: () => homeCubit,
			act: (cubit) => cubit.logout(),
			expect: () => [
				HomeLoading(),
				HomeLoggedOut(),
			],
		);
	});
}
