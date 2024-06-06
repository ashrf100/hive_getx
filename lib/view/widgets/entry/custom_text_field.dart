import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final IconData prefixIcon;
  final String? suffixText;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final int? maxLength;
  final void Function(String)? onChanged;

  const CustomTextField({
    Key? key,
    required this.controller,
    required this.labelText,
    required this.hintText,
    required this.prefixIcon,
    this.suffixText,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.maxLength,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: Colors.grey.shade300, width: 1.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: Colors.deepPurple.shade700, width: 1.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: Colors.deepPurple.shade300, width: 1.0),
        ),
        prefixIcon: Icon(prefixIcon, color: Colors.grey.shade600),
        suffixIcon: suffixText != null
            ? Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(suffixText!),
              )
            : null,
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      keyboardType: keyboardType,
      maxLength: maxLength,
      validator: validator,
      onChanged: onChanged,
    );
  }
}
