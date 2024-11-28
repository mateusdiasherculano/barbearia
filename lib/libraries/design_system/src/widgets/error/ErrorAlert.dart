import 'package:flutter/material.dart';

class ErrorAlert extends StatelessWidget {
  final String? message;

  const ErrorAlert({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: const Color(0xFFB3261E),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Flexible(
                child: Text.rich(TextSpan(children: [
                  TextSpan(
                    text: '$message',
                  )
                ])),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
