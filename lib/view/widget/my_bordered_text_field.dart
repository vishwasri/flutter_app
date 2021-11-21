import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class BorderedTextField extends StatefulWidget {
  final String name;
  final String labelText;
  final String obscuringCharacter;
  final bool obscureText;
  final double borderRadius;
  final double borderWidth;
  final TextInputType keyboardType;
  final AutovalidateMode autoValidateMode;
  final TextEditingController controller;
  final double horizontalContentPadding;
  final TextAlign textAlign;
  final TextInputAction inputAction;
  final String? Function(String?) validator;

  const BorderedTextField({
    required this.labelText,
    required this.name,
    required this.controller,
    this.obscureText = false,
    this.borderRadius = 5,
    this.borderWidth = 1,
    this.keyboardType = TextInputType.text,
    this.autoValidateMode = AutovalidateMode.onUserInteraction,
    this.horizontalContentPadding = 20.0,
    this.textAlign = TextAlign.left,
    this.inputAction = TextInputAction.next,
    this.obscuringCharacter = '*',
    Key? key,
    required this.validator,
  }) : super(key: key);
  @override
  _BorderedTextFieldState createState() => _BorderedTextFieldState();
}

class _BorderedTextFieldState extends State<BorderedTextField> {
  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      controller: widget.controller,
      obscuringCharacter: widget.obscuringCharacter,
      autovalidateMode: widget.autoValidateMode,
      textAlign: widget.textAlign,
      decoration: InputDecoration(
        hintText: widget.labelText,
        counterText: "",
        filled: true,
        fillColor: Colors.white,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          borderSide:
              BorderSide(width: widget.borderWidth, color: Colors.green),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          borderSide: BorderSide(width: widget.borderWidth, color: Colors.grey),
        ),
        contentPadding: EdgeInsets.fromLTRB(widget.horizontalContentPadding,
            0.0, widget.horizontalContentPadding, 0.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          borderSide:
              BorderSide(width: widget.borderWidth, color: Colors.white),
        ),
      ),
      obscureText: widget.obscureText,
      keyboardType: widget.keyboardType,
      textInputAction: widget.inputAction,
      validator: widget.validator,
      name: widget.name,
    );
  }
}
