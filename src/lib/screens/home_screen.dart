
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:com.example.my_flutter_app/cubits/home_cubit.dart';

class HomeScreen extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		final homeCubit = context.read<HomeCubit>();

		return Scaffold(
			appBar: AppBar(
				title: Text('Home'),
			),
			body: Center(
				child: ElevatedButton(
					onPressed: () {
						homeCubit.logout();
					},
					child: Text('Logout'),
				),
			),
		);
	}
}
