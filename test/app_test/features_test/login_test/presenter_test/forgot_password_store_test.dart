import 'package:barbearia/app/features/login/domain/user_cases/forgot_password_usecase.dart';
import 'package:barbearia/app/features/login/presenter/forgot_password_store.dart';
import 'package:barbearia/app/features/register_information/domain/entity/user_profile_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockForgotPasswordUseCase extends Mock implements ForgotPasswordUseCase {}

void main() {
  late MockForgotPasswordUseCase mockForgotPasswordUseCase;
  late ForgotPasswordStore forgotPasswordStore;

  const email = 'teste@email.com';

  mockSucessForgotPassword() {
    when(() => mockForgotPasswordUseCase.call(email)).thenAnswer(
        (_) async => MessageResponse(message: 'E-mail enviado com sucesso'));
  }

  setUp(() {
    mockForgotPasswordUseCase = MockForgotPasswordUseCase();
    forgotPasswordStore = ForgotPasswordStore(mockForgotPasswordUseCase);
  });

  group('ForgotPasswordStore - tests', () {
    test('Should call() usecase usecase with correct parameters', () async {
      mockSucessForgotPassword();
      await forgotPasswordStore.resetPassword(email);
      verify(() => mockForgotPasswordUseCase.call(email)).called(1);
    });

    test('Should update state.message with sucess response', () async {
      mockSucessForgotPassword();
      await forgotPasswordStore.resetPassword(email);
      expect(forgotPasswordStore.state.message,
          equals('E-mail enviado com sucesso'));
    });

    test('Should set error when usecase throws exception', () async {
      final exception = Exception('Erro no envio de e-mail');
      when(() => mockForgotPasswordUseCase.call(email)).thenAnswer((_) async {
        throw exception;
      });
      await forgotPasswordStore.resetPassword(email);
      expect(forgotPasswordStore.error, equals(exception));
    });

    test('Should toggle isLoading during execution', () async {
      when(() => mockForgotPasswordUseCase.call(email)).thenAnswer((_) async {
        expect(forgotPasswordStore.isLoading, isTrue);
        return MessageResponse(message: 'Tudo certo');
      });
      expect(forgotPasswordStore.isLoading, isFalse);
      await forgotPasswordStore.resetPassword(email);
      expect(forgotPasswordStore.isLoading, isFalse);
    });
  });
}
