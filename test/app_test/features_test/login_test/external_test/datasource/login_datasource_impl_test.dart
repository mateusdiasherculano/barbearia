import 'package:barbearia/app/features/login/external/datasource/login_datasource_impl.dart';
import 'package:barbearia/app/features/register_information/domain/entity/user_profile_model.dart';
import 'package:barbearia/libraries/core/src/error/failure.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockUserCredential extends Mock implements UserCredential {}

void main() {
  late LoginDatasourceImpl datasource;
  late MockFirebaseAuth mockFirebaseAuth;

  const email = 'teste@gmail.com';
  const password = '123456';
  final fakeUserCredential = MockUserCredential();

  setUp(() {
    mockFirebaseAuth = MockFirebaseAuth();
    datasource = LoginDatasourceImpl(mockFirebaseAuth);
  });

  void mockLoginSucess() {
    when(() => mockFirebaseAuth.signInWithEmailAndPassword(
          email: email,
          password: password,
        )).thenAnswer((_) async => fakeUserCredential);
  }

  group('LoginDatasourceImpl tests', () {
    test('Should call signInWithEmailAndPassword with correct params',
        () async {
      mockLoginSucess();
      await mockFirebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      verify(() => mockFirebaseAuth.signInWithEmailAndPassword(
            email: email,
            password: password,
          )).called(1);
    });

    test('Should return UserProfileModel if login is successful', () async {
      mockLoginSucess();
      final result = await datasource.login(email, password);
      expect(result, isA<UserProfileModel>());
    });

    test(
        'Should throw a string if FirebaseAuthException code is network-request-failed',
        () {
      const code = 'network-request-failed';
      when(() => mockFirebaseAuth.signInWithEmailAndPassword(
            email: email,
            password: password,
          )).thenThrow(FirebaseAuthException(code: code));

      expect(() => datasource.login(email, password),
          throwsA('Verifique sua rede.'));
    });

    test('Should throw a Failure if FirebaseAuthException has another code',
        () async {
      const userNotFound = 'user-not-found';
      const message = 'Usuário não encontrado';
      when(() => mockFirebaseAuth.signInWithEmailAndPassword(
                email: email,
                password: password,
              ))
          .thenThrow(
              FirebaseAuthException(code: userNotFound, message: message));

      expect(() => datasource.login(email, password), throwsA(isA<Failure>()));
    });

    test('Should throw generic Exception if other error occurs', () {
      const error = 'Erro inesperado';
      when(() => mockFirebaseAuth.signInWithEmailAndPassword(
            email: email,
            password: password,
          )).thenThrow(Exception(error));

      expect(
          () => datasource.login(email, password), throwsA(isA<Exception>()));
    });
  });
}
