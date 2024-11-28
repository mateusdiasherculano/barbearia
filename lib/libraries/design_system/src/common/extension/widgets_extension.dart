import 'package:barbearia/libraries/design_system/src/widgets/error/ErrorAlert.dart';
import 'package:barbearia/libraries/design_system/src/widgets/error/sucess_alert.dart';
import 'package:flutter/material.dart';

extension ErrorAlertWidgetExtension on ErrorAlert {
  show(BuildContext context) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: ErrorAlert(
          message: message,
        ),
        backgroundColor: Colors.white,
      ));
    }
  }
}

extension SuccessAlertWidgetExtension on SuccessAlert {
  show(BuildContext context) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: SuccessAlert(
          message: message,
        ),
        backgroundColor: Colors.white,
      ));
    }
  }
}
