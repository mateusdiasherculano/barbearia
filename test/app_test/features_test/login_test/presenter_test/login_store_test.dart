import 'package:barbearia/app/features/login/domain/user_cases/login_usecase.dart';
import 'package:barbearia/app/features/login/presenter/log_in_store.dart';
import 'package:barbearia/app/features/register_information/domain/entity/user_profile_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockLoginUseCase extends Mock implements LoginUseCase {}

void main() {
  late LoginStore store;
  late MockLoginUseCase mockLoginUseCase;

  setUp(() {
    mockLoginUseCase = MockLoginUseCase();
    store = LoginStore(mockLoginUseCase);
  });

  const email = 'teste@gmail.com';
  const password = '123456';
  final fakeUser = UserProfileModel(uid: 'abc123', email: email);

  void mockLoginSucess() {
    when(() => mockLoginUseCase.call(email, password))
        .thenAnswer((_) async => fakeUser);
  }

  group('LoginStore tests', () {
    test('login() Should call usecase with correct parameters', () async {
      mockLoginSucess();
      await store.login(email, password);

      verify(() => mockLoginUseCase.call(email, password)).called(1);
    });

    test('Should update state with returned UserProfileModel', () async {
      mockLoginSucess();
      await store.login(email, password);

      expect(store.state.uid, equals('abc123'));
      expect(store.state.email, equals(email));
    });

    test('Should set error if usecase throws an exception', () async {
      final exception = Exception('erro de login');

      when(() => mockLoginUseCase.call(email, password)).thenAnswer((_) async {
        throw exception;
      });

      await store.login(email, password);

      expect(store.error, equals(exception));
    });

    test('Should toggle isLoading correctly during execution', () async {
      when(() => mockLoginUseCase.call(email, password)).thenAnswer((_) async {
        expect(store.isLoading, true); // durante
        return fakeUser;
      });

      expect(store.isLoading, isFalse); // antes
      await store.login(email, password);
      expect(store.isLoading, isFalse); // depois
    });
  });
}
