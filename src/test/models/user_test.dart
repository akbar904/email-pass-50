
// test/models/user_test.dart

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import '../../lib/models/user.dart';

void main() {
	group('User Model', () {
		test('should correctly serialize from JSON', () {
			final json = {'email': 'test@example.com', 'password': 'password123'};
			final user = User.fromJson(json);

			expect(user.email, 'test@example.com');
			expect(user.password, 'password123');
		});

		test('should correctly deserialize to JSON', () {
			final user = User(email: 'test@example.com', password: 'password123');
			final json = user.toJson();

			expect(json, {'email': 'test@example.com', 'password': 'password123'});
		});
		
		test('should create a User object with valid email and password', () {
			final user = User(email: 'test@example.com', password: 'password123');

			expect(user.email, 'test@example.com');
			expect(user.password, 'password123');
		});

		test('should throw an error for invalid email format', () {
			expect(() => User(email: 'invalidemail', password: 'password123'), throwsArgumentError);
		});

		test('should throw an error for empty password', () {
			expect(() => User(email: 'test@example.com', password: ''), throwsArgumentError);
		});
	});
}
