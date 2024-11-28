import 'package:flutter/material.dart';

class OutlineLoadingButton extends StatelessWidget {
  final bool loading;
  final String text;
  final VoidCallback? onPressed;

  const OutlineLoadingButton(
      {Key? key, required this.loading, required this.text, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: loading ? 60 : MediaQuery.of(context).size.width,
      height: 60,
      child: OutlinedButton(
        onPressed: loading ? () {} : onPressed,
        style: OutlinedButton.styleFrom(
          side: const BorderSide(width: 1),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        child: Text(
          text,
          textHeightBehavior:
              const TextHeightBehavior(applyHeightToFirstAscent: false),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
