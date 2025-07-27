import 'package:barbearia/app/features/login/infra/datasources/login_datasource.dart';
import 'package:barbearia/app/features/login/infra/repository/login_repository_impl.dart';
import 'package:barbearia/app/features/register_information/domain/entity/user_profile_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockLoginDataSource extends Mock implements LoginDatasource {}

void main() {
  late LoginRepositoryImpl repository;
  late MockLoginDataSource mockLoginDataSource;

  const email = 'teste@gmail.com';
  const password = '123456';
  final fakeUser = UserProfileModel(uid: 'abc123', email: email);

  setUp(() {
    mockLoginDataSource = MockLoginDataSource();
    repository = LoginRepositoryImpl(mockLoginDataSource);
  });

  void mockLoginSucess() {
    when(() => mockLoginDataSource.login(email, password))
        .thenAnswer((_) async => fakeUser);
  }

  group('Login repository tests', () {
    test('Should call the dataSource login method with the correct parameters',
        () async {
      mockLoginSucess();
      await repository.login(email, password);
      verify(() => mockLoginDataSource.login(email, password)).called(1);
    });

    test(
        'Should return a UserProfileModel if the datasource returns successfully',
        () async {
      mockLoginSucess();
      final result = await repository.login(email, password);
      expect(result, fakeUser);
    });

    test('Should throw an exception if the datasource fails', () async {
      const exception = 'error logging in';
      when(() => mockLoginDataSource.login(email, password))
          .thenThrow(exception);

      expect(() => repository.login(email, password), throwsA(exception));
    });
  });
}
