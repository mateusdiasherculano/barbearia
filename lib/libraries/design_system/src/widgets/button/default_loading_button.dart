import 'package:flutter/material.dart';

class DefaultLoadingButton extends StatelessWidget {
  final bool loading;
  final String text;
  final VoidCallback? onPressed;
  final List<Color>? colors;

  const DefaultLoadingButton(
      {Key? key,
      required this.loading,
      required this.text,
      this.onPressed,
      this.colors})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: loading ? 60 : MediaQuery.of(context).size.width,
      height: 60,
      decoration: onPressed == null
          ? BoxDecoration(
              color: const Color(0xffcccccc),
              borderRadius: BorderRadius.circular(8.0),
            )
          : BoxDecoration(
              gradient: LinearGradient(
                begin: const Alignment(-1.0, -0.84),
                end: const Alignment(1.0, 1.0),
                colors: colors ??
                    [const Color(0xFF000000), const Color(0xFF000000)],
                stops: const [0.0, 1.0],
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.all(8)),
          onPressed: loading ? () {} : onPressed,
          child: Text(
            text.toString(),
            style: const TextStyle(color: Colors.white),
            textHeightBehavior:
                const TextHeightBehavior(applyHeightToFirstAscent: false),
            textAlign: TextAlign.center,
          )),
    );
  }
}
