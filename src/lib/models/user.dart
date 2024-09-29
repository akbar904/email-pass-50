
import 'dart:convert';

class User {
	final String email;
	final String password;

	User({
		required this.email,
		required this.password,
	}) {
		if (!_isValidEmail(email)) {
			throw ArgumentError('Invalid email format');
		}
		if (password.isEmpty) {
			throw ArgumentError('Password cannot be empty');
		}
	}

	factory User.fromJson(Map<String, dynamic> json) {
		return User(
			email: json['email'],
			password: json['password'],
		);
	}

	Map<String, dynamic> toJson() {
		return {
			'email': email,
			'password': password,
		};
	}

	bool _isValidEmail(String email) {
		final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
		return emailRegex.hasMatch(email);
	}
}
