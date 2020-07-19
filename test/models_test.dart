import 'package:chatapp/business_logic/models/user.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('User model', () async {
    User user = User();
    user.email = 'test@test.test';

    expect(user.email, 'test@test.test');
  });
}