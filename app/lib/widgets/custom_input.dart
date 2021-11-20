import 'package:flutter/material.dart';


class CustomInput extends StatelessWidget {

  final String hintText;
  final String labelText;
  final bool obscureText;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final IconData prefixIcon;

  CustomInput({
    required this.hintText, 
    required this.labelText, 
    required this.validator, 
    required this.onChanged, 
    required this.prefixIcon, 
    this.obscureText = false, 
    this.keyboardType = TextInputType.text
  });


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 15
      ),
      child: TextFormField(
          autocorrect: false,
          keyboardType: keyboardType,
          obscureText: obscureText,
          decoration: InputDecoration(
              prefixIcon: Icon( prefixIcon, color: Colors.deepPurple ),
              hintText: hintText,
              labelText: labelText,
              labelStyle: TextStyle(
                color: Colors.black54
              ),
              contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              enabledBorder:  OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Color(0xFF7E57C2),
                ),
                borderRadius: BorderRadius.circular(20)
              ), 
              border: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Color(0xFF7E57C2)
                ),
                borderRadius: BorderRadius.circular(20)
              ), 
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xFF7E57C2)
                ),
                borderRadius: BorderRadius.circular(20)
              ),
              focusColor:  Color(0xFF7E57C2),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.red
                ),
                borderRadius: BorderRadius.circular(20)
              )
            ),
            validator: validator,
            onChanged: onChanged,
      ),
    );
  }
}