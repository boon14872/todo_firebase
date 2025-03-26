import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final bool isObscure;
  final TextInputType inputType;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final GlobalKey<FormState>? formKey;
  final List<TextInputFormatter>? inputFormatters;
  final int maxLength;

  const AppTextField({
    super.key,
    required this.controller,
    required this.label,
    this.hint = '',
    this.isObscure = false,
    this.inputType = TextInputType.text,
    this.validator,
    this.onChanged,
    this.formKey,
    this.inputFormatters,
    this.maxLength = 100,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: TextFormField(
        controller: controller,
        obscureText: isObscure,
        keyboardType: inputType,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          counterText: '',
          labelStyle: GoogleFonts.itim(fontSize: 16, color: Colors.black),
          hintStyle: GoogleFonts.itim(fontSize: 16, color: Colors.grey),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32)),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 8,
          ),
        ),
        maxLength: maxLength,
        validator: validator,
        onChanged: onChanged,
        inputFormatters: inputFormatters,
      ),
    );
  }
}
