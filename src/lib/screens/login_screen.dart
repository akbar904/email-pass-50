
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/login_cubit.dart';

class LoginScreen extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: Text('Login'),
			),
			body: Padding(
				padding: const EdgeInsets.all(16.0),
				child: BlocProvider(
					create: (context) => LoginCubit(),
					child: LoginForm(),
				),
			),
		);
	}
}

class LoginForm extends StatefulWidget {
	@override
	_LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
	final _formKey = GlobalKey<FormState>();
	final _emailController = TextEditingController();
	final _passwordController = TextEditingController();

	@override
	void dispose() {
		_emailController.dispose();
		_passwordController.dispose();
		super.dispose();
	}

	@override
	Widget build(BuildContext context) {
		return Form(
			key: _formKey,
			child: Column(
				children: [
					TextFormField(
						controller: _emailController,
						decoration: InputDecoration(labelText: 'Email'),
						validator: (value) {
							if (value == null || value.isEmpty) {
								return 'Please enter your email';
							}
							return null;
						},
					),
					TextFormField(
						controller: _passwordController,
						decoration: InputDecoration(labelText: 'Password'),
						obscureText: true,
						validator: (value) {
							if (value == null || value.isEmpty) {
								return 'Please enter your password';
							}
							return null;
						},
					),
					SizedBox(height: 16),
					ElevatedButton(
						onPressed: () {
							if (_formKey.currentState!.validate()) {
								BlocProvider.of<LoginCubit>(context).login(
									_emailController.text,
									_passwordController.text,
								);
							}
						},
						child: Text('Login'),
					),
					BlocBuilder<LoginCubit, LoginState>(
						builder: (context, state) {
							if (state is LoginLoading) {
								return CircularProgressIndicator();
							} else if (state is LoginFailure) {
								return Text(state.error, style: TextStyle(color: Colors.red));
							}
							return Container();
						},
					),
				],
			),
		);
	}
}
