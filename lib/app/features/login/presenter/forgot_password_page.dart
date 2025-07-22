import 'package:barbearia/app/features/login/presenter/forgot_password_controller.dart';
import 'package:barbearia/components/custom_text_widget.dart';
import 'package:barbearia/libraries/core/src/extension/string_extensions.dart';
import 'package:barbearia/libraries/design_system/src/common/extension/widgets_extension.dart';
import 'package:barbearia/libraries/design_system/src/widgets/button/button_loading.dart';
import 'package:barbearia/libraries/design_system/src/widgets/error/ErrorAlert.dart';
import 'package:barbearia/libraries/design_system/src/widgets/error/sucess_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ForgotPasswordPage extends StatefulWidget {
  final String title;

  const ForgotPasswordPage({Key? key, this.title = 'ForgotPasswordPage'})
      : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final ForgotPasswordController controller =
      Modular.get<ForgotPasswordController>();
  final TextEditingController emailTextEditingController =
      TextEditingController();
  final TextEditingController passwordTextEditingController =
      TextEditingController();
  final TextEditingController passwordConfirmEditingController =
      TextEditingController();

  @override
  void initState() {
    controller.store.observer(
      onState: (state) {
        SuccessAlert(message: state.message).show(context);
        Modular.to.navigate('/login/');
      },
      onError: (error) {
        ErrorAlert(message: error?.message).show(context);
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    emailTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFf6f6f6),
      child: SafeArea(
          child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Forgot Password',
            style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 18,
              color: Color(0xFF1D192B),
              fontWeight: FontWeight.w600,
              height: 1.1764705882352942,
            ),
            textHeightBehavior:
                TextHeightBehavior(applyHeightToFirstAscent: false),
            softWrap: false,
          ),
          iconTheme: const IconThemeData(color: Color(0XFF353B50)),
          backgroundColor: const Color(0XFFF6F6F6),
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Image.asset('assets/images/logoseta.png'),
                  ),
                  const SizedBox(height: 48),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: const Text(
                      'Please enter your email address to reset your password.',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 17,
                        color: Color(0xFF49454F),
                        height: 1.1764705882352942,
                      ),
                      textHeightBehavior:
                          TextHeightBehavior(applyHeightToFirstAscent: false),
                      textAlign: TextAlign.center,
                      softWrap: true,
                    ),
                  ),
                  const SizedBox(height: 48),
                  AnimatedBuilder(
                      animation: Listenable.merge(
                          [controller.emailError, controller.emailValidation]),
                      builder: (context, _) {
                        return AutofillGroup(
                            child: CustomTextField(
                          controller: emailTextEditingController,
                          icon: Icons.email,
                          label: 'E-mail',
                          keyboardType: TextInputType.emailAddress,
                          errorMessage: controller.emailError.value,
                          showValidated: controller.emailValidation.value,
                          autofillHints: const <String>[AutofillHints.email],
                          onChanged: (value) {
                            controller.emailError.value = null;
                            controller.emailValidation.value = value.isEmail;
                          },
                        ));
                      }),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
        bottomSheet: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: AnimatedBuilder(
                    animation: controller.store.selectLoading,
                    builder: (context, _) {
                      return ButtonLoading(
                          onPressed: () {
                            FocusManager.instance.primaryFocus?.unfocus();
                            controller
                                .resetPassword(emailTextEditingController.text);
                          },
                          text: 'Reset Password',
                          loading: controller.store.isLoading);
                    }),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      )),
    );
  }
}
