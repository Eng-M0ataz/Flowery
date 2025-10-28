import 'package:flutter/material.dart';

class CustomPasswordTextFormField extends StatefulWidget {
  const CustomPasswordTextFormField({
    super.key,
    this.onChanged,
    this.validator,
    required this.controller,
    required this.hint,
    required this.label,
  });
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final String hint;
  final String label;

  @override
  State<CustomPasswordTextFormField> createState() =>
      _CustomPasswordTextFormFieldState();
}

class _CustomPasswordTextFormFieldState
    extends State<CustomPasswordTextFormField> {
  bool obscureText = true;
  void _togglePasswordVisibility() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUnfocus,
      onChanged: widget.onChanged,
      obscureText: obscureText,
      validator: widget.validator,
      controller: widget.controller,
      decoration: InputDecoration(
        hintText: widget.hint,
        labelText: widget.label,
        suffixIcon: IconButton(
          icon: Icon(obscureText ? Icons.visibility_off : Icons.visibility),
          onPressed: _togglePasswordVisibility,
        ),
      ),
    );
  }
}
