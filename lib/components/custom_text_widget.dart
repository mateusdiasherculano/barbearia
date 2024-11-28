import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomTextField extends StatefulWidget {
  final IconData? icon;
  final String? label;
  final bool isSecret;
  final List<TextInputFormatter>? inputFormatters;
  final String? initialValue;
  final TextEditingController? controller;
  final Widget? iconSufix;
  final TextInputType? keyboardType;
  final String? errorMessage;
  final bool? showValidated;
  final ValueChanged<String>? onChanged;
  final List<String>? autofillHints;
  final bool? obscureText;

  const CustomTextField({
    Key? key,
    this.icon,
    this.label,
    this.isSecret = false,
    this.inputFormatters,
    this.initialValue,
    this.controller,
    this.errorMessage,
    this.showValidated,
    this.autofillHints,
    this.onChanged,
    this.keyboardType,
    this.obscureText,
    this.iconSufix,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isObscure = false;

  @override
  void initState() {
    super.initState();
    isObscure = widget.isSecret;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: TextFormField(
        onChanged: widget.onChanged,
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        autofillHints: widget.autofillHints,
        initialValue: widget.initialValue,
        inputFormatters: widget.inputFormatters,
        obscureText: isObscure,
        decoration: InputDecoration(
          labelText: widget.label,
          errorText: widget.errorMessage,
          suffixIcon: widget.iconSufix ?? _getSuffixIcon(),
          prefixIcon: Icon(widget.icon),
          isDense: true,
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
        ),
      ),
    );
  }

  Widget? _getSuffixIcon() {
    if (widget.obscureText != null) {
      return IconButton(
        icon: Icon(
          (isObscure == false ? Icons.visibility : Icons.visibility_off),
        ),
        onPressed: () {
          setState(() {
            isObscure = !(isObscure == true);
          });
        },
      );
    } else {
      if (widget.showValidated == true) {
        return const Icon(
          FontAwesomeIcons.check,
          color: Color(0xff03A9F4),
          size: 16,
        );
      }
    }
  }
}
