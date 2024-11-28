import 'package:barbearia/app/features/register_information/presenter/register_information_controller.dart';
import 'package:barbearia/components/custom_text_widget.dart';
import 'package:barbearia/libraries/core/src/extension/string_extensions.dart';
import 'package:barbearia/libraries/design_system/src/common/extension/widgets_extension.dart';
import 'package:barbearia/libraries/design_system/src/widgets/button/button_loading.dart';
import 'package:barbearia/libraries/design_system/src/widgets/error/ErrorAlert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../libraries/design_system/src/widgets/error/sucess_alert.dart';

class PersonalInformationPage extends StatefulWidget {
  const PersonalInformationPage({Key? key}) : super(key: key);

  @override
  State<PersonalInformationPage> createState() =>
      _PersonalInformationPageState();
}

class _PersonalInformationPageState extends State<PersonalInformationPage> {
  RegisterInformationController controller =
      Modular.get<RegisterInformationController>();
  final TextEditingController fullNameTextEditingController =
      TextEditingController();
  final TextEditingController emailTextEditingController =
      TextEditingController();
  final TextEditingController passwordTextEditingController =
      TextEditingController();
  final TextEditingController phoneTextEditingController =
      TextEditingController();

  @override
  void initState() {
    controller.store.observer(onState: (state) {
      SuccessAlert(message: state.message).show(context);
      _clearTextFields();
      Modular.to.pushNamed('/upload');
    }, onError: (error) {
      ErrorAlert(
        message: error?.message,
      ).show(context);
    });
    super.initState();
  }

  void _clearTextFields() {
    fullNameTextEditingController.clear();
    emailTextEditingController.clear();
    passwordTextEditingController.clear();
    phoneTextEditingController.clear();
  }

  @override
  void dispose() {
    phoneTextEditingController.dispose();
    passwordTextEditingController.dispose();
    fullNameTextEditingController.dispose();
    emailTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFf6f6f6),
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    const Center(
                      child: Text(
                        'Informações Pessoais',
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    AnimatedBuilder(
                      animation: controller.nameError,
                      builder: (context, _) {
                        return AutofillGroup(
                          child: CustomTextField(
                            controller: fullNameTextEditingController,
                            icon: Icons.person,
                            label: 'Nome',
                            keyboardType: TextInputType.name,
                            errorMessage: controller.nameError.value,
                            onChanged: (value) {
                              controller.nameError.value = null;
                            },
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    AnimatedBuilder(
                      animation: Listenable.merge(
                          [controller.emailError, controller.emailValidation]),
                      builder: (context, _) {
                        return AutofillGroup(
                          child: CustomTextField(
                            controller: emailTextEditingController,
                            icon: Icons.email_outlined,
                            label: 'E-mail',
                            keyboardType: TextInputType.emailAddress,
                            errorMessage: controller.emailError.value,
                            autofillHints: const <String>[AutofillHints.email],
                            showValidated: controller.emailValidation.value,
                            onChanged: (value) {
                              controller.emailError.value = null;
                              controller.emailValidation.value = value.isEmail;
                            },
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    AnimatedBuilder(
                      animation: controller.passwordError,
                      builder: (context, _) {
                        return AutofillGroup(
                            child: CustomTextField(
                          controller: passwordTextEditingController,
                          icon: Icons.lock,
                          label: 'Senha',
                          keyboardType: TextInputType.emailAddress,
                          errorMessage: controller.passwordError.value,
                          autofillHints: const <String>[AutofillHints.password],
                          obscureText: true,
                          onChanged: (value) {
                            controller.passwordError.value = null;
                          },
                        ));
                      },
                    ),
                    const SizedBox(height: 20),
                    AnimatedBuilder(
                      animation: controller.phoneError,
                      builder: (context, _) {
                        return AutofillGroup(
                            child: CustomTextField(
                          controller: phoneTextEditingController,
                          icon: Icons.phone_android_outlined,
                          label: 'Numero de telefone',
                          keyboardType: TextInputType.phone,
                          errorMessage: controller.phoneError.value,
                          autofillHints: const <String>[
                            AutofillHints.telephoneNumber
                          ],
                          onChanged: (value) {
                            controller.phoneNumber.value = value.isPhoneNumber;
                            controller.phoneError.value = null;
                          },
                        ));
                      },
                    ),
                    const SizedBox(height: 100),
                    AnimatedBuilder(
                      animation: controller.store.selectLoading,
                      builder: (context, _) {
                        return ButtonLoading(
                          onPressed: () {
                            controller.registerPersonal(
                                fullNameTextEditingController.text,
                                emailTextEditingController.text,
                                passwordTextEditingController.text,
                                phoneTextEditingController.text);
                          },
                          text: 'PRÓXIMO',
                          loading: controller.store.isLoading,
                        );
                      },
                    ),
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
