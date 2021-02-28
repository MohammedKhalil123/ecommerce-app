import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  final String hint;
  final IconData icon;
  final bool isPassword;
  final Function validation;
  final Function saved;

  CustomFormField(
      {@required this.hint,
      @required this.icon,
      @required this.isPassword,
      @required this.validation,
      @required this.saved});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isPassword,
      validator: (val) {
        return validation(val);
      },
      onSaved: (val) {
        saved(val);
      },
      cursorColor: Colors.black,
      decoration: InputDecoration(
          hintText: hint,
          prefixIcon: Icon(
            icon,
            color: Colors.black,
          ),
          filled: true,
          fillColor: Colors.white,
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: Colors.white)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: Colors.white)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: Colors.white)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: Colors.white))),
    );
  }
}
