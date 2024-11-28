import 'package:barbearia/libraries/design_system/src/widgets/button/button_progress.dart';
import 'package:barbearia/libraries/design_system/src/widgets/button/default_loading_button.dart';
import 'package:barbearia/libraries/design_system/src/widgets/button/outline_loading_button.dart';
import 'package:flutter/material.dart';

class ButtonLoading extends StatelessWidget {
  /// function to run when click
  final VoidCallback? onPressed;

  /// text that will show in widget
  final String text;

  /// loading controller
  final bool loading;
  final bool? outline;
  final bool? isSecondary;

  const ButtonLoading(
      {Key? key,
      required this.onPressed,
      required this.text,
      required this.loading,
      this.outline = false,
      this.isSecondary})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: loading ? 70 : MediaQuery.of(context).size.width,
      height: 70,
      alignment: Alignment.center,
      child: AnimatedCrossFade(
        firstChild: ButtonProgress(
          colors: isSecondary == true
              ? [const Color(0xFF000000), const Color(0xFF000000)]
              : null,
        ),
        secondChild: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 3),
          child: (outline == true)
              ? OutlineLoadingButton(
                  loading: loading, text: text, onPressed: onPressed)
              : DefaultLoadingButton(
                  loading: loading,
                  text: text,
                  onPressed: onPressed,
                  colors: isSecondary == true
                      ? [const Color(0xFF000000), const Color(0xFF000000)]
                      : null,
                ),
        ),
        crossFadeState:
            loading ? CrossFadeState.showFirst : CrossFadeState.showSecond,
        duration: const Duration(milliseconds: 200),
      ),
    );
  }
}
