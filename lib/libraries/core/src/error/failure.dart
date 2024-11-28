import 'package:barbearia/libraries/core/crashalytics/crashalytics_services.dart';

class Failure {
  final String? message;

  Failure({String? label, dynamic exception, this.message = ''}) {
    ErrorReport.externalFailureError(exception, label);
  }
}
