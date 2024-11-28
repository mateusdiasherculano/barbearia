import 'package:flutter/material.dart';

class ButtonProgress extends StatelessWidget {
  final List<Color>? colors;

  const ButtonProgress({Key? key, this.colors}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 60,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(48),
          gradient: LinearGradient(
            begin: const Alignment(-1.0, -0.84),
            end: const Alignment(1.0, 1.0),
            colors:
                colors ?? [const Color(0xFF000000), const Color(0xFF000000)],
            stops: const [0.0, 1.0],
          )),
      child: const SizedBox(
          width: 60,
          height: 60,
          child: Padding(
            padding: EdgeInsets.all(8),
            child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
          )),
    );
  }
}
