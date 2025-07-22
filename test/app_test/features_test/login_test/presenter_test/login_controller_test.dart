import 'package:barbearia/app/features/login/presenter/log_in_store.dart';
import 'package:barbearia/app/features/login/presenter/login_controller.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockLoginStore extends Mock implements LoginStore {}

void main() {
  late LoginController controller;
  late MockLoginStore mockStore;

  setUp(() {
    mockStore = MockLoginStore();
    controller = LoginController(mockStore);
  });

  group('Verificacao de login', () {
    test('email vazio gera erro emailError', () async {
      await controller.login('', '1123456');
      expect(controller.emailError.value, 'E-mail não pode ser vazio');
    });

    test('email invalido gera erro emailError', () async {
      await controller.login('emailinvalido', '123456');
      expect(controller.emailError.value, 'Email não é valido.');
    });

    test('senha vazia gera erro passwordError', () async {
      await controller.login('teste@gmail.com', '');
      expect(controller.passwordError.value, 'Senha nao pode ser vazia');
    });

    test('dados validos chama store.login', () async {
      when(() => mockStore.login(any(), any())).thenAnswer((_) async {});

      await controller.login('teste@gmail.com', '123456');

      verify(() => mockStore.login('teste@gmail.com', '123456')).called(1);

      expect(controller.emailError.value, null);
      expect(controller.passwordError.value, null);
    });
  });
}
