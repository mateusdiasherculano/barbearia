import 'package:barbearia/app/features/login/presenter/log_in_store.dart';
import 'package:barbearia/app/features/login/presenter/login_controller.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockLoginStore extends Mock implements LoginStore {}

void main() {
  late LoginController controller;
  late MockLoginStore mockStore;

  const emptyEmail = '';
  const invalidEmail = 'email.com';
  const email = 'teste@gmail.com';
  const password = '123456';
  const emptyPassword = '';

  setUp(() {
    mockStore = MockLoginStore();
    controller = LoginController(mockStore);
  });

  group('LoginController - Email validation', () {
    test('Should set emailError when email is empty', () async {
      await controller.login(emptyEmail, password);
      expect(controller.emailError.value, 'E-mail não pode ser vazio');
    });

    test('Should set emailError when email is invalid', () async {
      await controller.login(invalidEmail, password);
      expect(controller.emailError.value, 'Email não é valido.');
    });
  });

  group('LoginController - Password validation', () {
    test('Should set passwordError when password is empty', () async {
      await controller.login(email, emptyPassword);
      expect(controller.passwordError.value, 'Senha nao pode ser vazia');
    });
  });

  group('LoginController - Valid credentials', () {
    test('Should call store.login() with correct parameters when data is valid',
        () async {
      when(() => mockStore.login(any(), any())).thenAnswer((_) async {});

      await controller.login(email, password);

      verify(() => mockStore.login(email, password)).called(1);

      expect(controller.emailError.value, null);
      expect(controller.passwordError.value, null);
    });
  });
}
