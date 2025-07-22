import 'package:barbearia/app/features/login/presenter/login_controller.dart';
import 'package:barbearia/components/custom_text_widget.dart';
import 'package:barbearia/libraries/core/src/extension/string_extensions.dart';
import 'package:barbearia/libraries/design_system/src/common/extension/widgets_extension.dart';
import 'package:barbearia/libraries/design_system/src/widgets/button/button_loading.dart';
import 'package:barbearia/libraries/design_system/src/widgets/error/ErrorAlert.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LoginController controller = Modular.get<LoginController>();
  final TextEditingController emailTextEditingController =
      TextEditingController();
  final TextEditingController passwordTextEditingController =
      TextEditingController();

  @override
  void initState() {
    controller.store.observer(onState: (state) {
      // alteração essa rota para a tela home
      Modular.to.navigate('/BarberDashboard/');
    }, onError: (error) {
      ErrorAlert(
        message: error?.message,
      ).show(context);
    });
    super.initState();
  }

  @override
  void dispose() {
    emailTextEditingController.dispose();
    passwordTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key('LoginPage'),
      color: const Color(0xFFf6f6f6),
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 45),
                    Center(
                      child: Image.asset('assets/images/logoseta.png'),
                    ),
                    const SizedBox(height: 48),
                    const Text(
                      'Bem-vindo de volta.',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 40),

                    /// campo de email
                    AnimatedBuilder(
                        animation: Listenable.merge([
                          controller.emailError,
                          controller.emailValidation
                        ]),
                        builder: (context, _) {
                          return AutofillGroup(
                            child: CustomTextField(
                              key: const Key('Campo email'),
                              controller: emailTextEditingController,
                              icon: Icons.email,
                              label: 'E-mail',
                              keyboardType: TextInputType.emailAddress,
                              errorMessage: controller.emailError.value,
                              autofillHints: const <String>[
                                AutofillHints.email
                              ],
                              showValidated: controller.emailValidation.value,
                              onChanged: (value) {
                                controller.emailError.value = null;
                                controller.emailValidation.value =
                                    value.isEmail;
                              },
                            ),
                          );
                        }),
                    const SizedBox(height: 15),

                    /// campo de password
                    AnimatedBuilder(
                        animation: controller.passwordError,
                        builder: (context, _) {
                          return AutofillGroup(
                              child: CustomTextField(
                            key: const Key('Campo senha'),
                            controller: passwordTextEditingController,
                            icon: Icons.lock,
                            label: 'Senha',
                            keyboardType: TextInputType.text,
                            errorMessage: controller.passwordError.value,
                            autofillHints: const <String>[
                              AutofillHints.password
                            ],
                            obscureText: true,
                            onChanged: (value) {
                              controller.passwordError.value = null;
                            },
                          ));
                        }),
                    const SizedBox(height: 8),

                    ///campo de redefinir senha
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        key: const Key('Campo esqueceu a senha'),
                        onPressed: () {
                          Modular.to.pushNamed('/login/forgot_password');
                        },
                        child: const Text(
                          'Esqueceu sua senha?',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                    const SizedBox(height: 50),

                    /// botao de login
                    AnimatedBuilder(
                        animation: controller.store.selectLoading,
                        builder: (context, _) {
                          return ButtonLoading(
                              key: const Key('buttonLogin'),
                              onPressed: () {
                                FocusManager.instance.primaryFocus?.unfocus();
                                controller.login(
                                    emailTextEditingController.text,
                                    passwordTextEditingController.text);
                              },
                              text: 'Entrar',
                              loading: controller.store.isLoading);
                        }),
                    const SizedBox(height: 60),
                    Align(
                      alignment: Alignment.center,
                      child: RichText(
                        key: const Key('buttonRegisterNow'),
                        text: TextSpan(
                          style: const TextStyle(color: Colors.grey),
                          children: [
                            const TextSpan(text: "Não tem uma conta? "),
                            TextSpan(
                              text: 'Cadastre-se agora',
                              style: const TextStyle(color: Colors.black),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Modular.to.pushNamed('/register');
                                },
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
