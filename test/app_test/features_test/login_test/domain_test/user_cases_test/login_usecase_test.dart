import 'package:barbearia/app/features/login/domain/repository/login_repository.dart';
import 'package:barbearia/app/features/login/domain/user_cases/login_usecase.dart';
import 'package:barbearia/app/features/register_information/domain/entity/user_profile_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockLoginRepository extends Mock implements LoginRepository {}

void main() {
  late LoginUseCase useCase;
  late MockLoginRepository mockRepository;

  const email = 'teste@gmail.com';
  const password = '123456';
  final fakeUser = UserProfileModel(uid: 'abc123', email: email);

  setUp(() {
    mockRepository = MockLoginRepository();
    useCase = LoginUseCase(mockRepository);
  });

  void mockLoginSucess() {
    when(() => mockRepository.login(email, password))
        .thenAnswer((_) async => fakeUser);
  }

  group('Login UseCase tests', () {
    test(
        "Should call the repository's login method with the correct parameters",
        () async {
      mockLoginSucess();
      await useCase.call(email, password);
      verify(() => mockRepository.login(email, password)).called(1);
    });

    test('Should return the UserProfileModel returned by the repository',
        () async {
      mockLoginSucess();
      final result = await useCase.call(email, password);
      expect(result, equals(fakeUser));
    });

    test('Should throw an exception if the repository throws one', () async {
      final exception = Exception('erro no repositorio');
      when(() => mockRepository.login(email, password)).thenThrow(exception);
      expect(() => useCase.call(email, password), throwsA(exception));
    });
  });
}
