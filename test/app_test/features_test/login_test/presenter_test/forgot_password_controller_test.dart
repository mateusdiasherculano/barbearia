import 'package:barbearia/app/features/login/presenter/forgot_password_controller.dart';
import 'package:barbearia/app/features/login/presenter/forgot_password_store.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockForgotPasswordStore extends Mock implements ForgotPasswordStore {}

void main() {
  late ForgotPasswordController controller;
  late MockForgotPasswordStore mockForgotPasswordStore;

  const emptyEmail = '';
  const invalidEmail = 'email.com';
  const email = 'teste@gmail.com';

  setUp(() {
    mockForgotPasswordStore = MockForgotPasswordStore();
    controller = ForgotPasswordController(mockForgotPasswordStore);
  });

  group('ForgotPasswordController - Tests', () {
    test('should set emailError when email is empty', () async {
      await controller.resetPassword(emptyEmail);
      expect(controller.emailError.value, 'E-mail não pode ser vazio');
    });

    test('Should set emailError when email is invalid', () async {
      await controller.resetPassword(invalidEmail);
      expect(controller.emailError.value, 'E-mail nao é valido');
    });
  });

  group('ForgotPasswordController - Valid credentials', () {
    test(
        'Should call store.resetPassword() with correct parameters when data is valid',
        () async {
      when(() => mockForgotPasswordStore.resetPassword(email))
          .thenAnswer((_) async {});
      await controller.resetPassword(email);
      verify(() => mockForgotPasswordStore.resetPassword(email)).called(1);
      expect(controller.emailError.value, null);
    });
  });
}
