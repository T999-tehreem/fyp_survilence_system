import 'package:flutter/material.dart';

class AppTextField2 extends StatelessWidget {
  const AppTextField2({
    Key? key,
    required this.textEditingController,
    this.textInputType = TextInputType.text,
    this.obscureText = false,
    this.hint = '',
    this.readonly = false,
  }) : super(key: key);

  final String hint;
  final TextInputType textInputType;
  final TextEditingController textEditingController;
  final bool obscureText;
  final bool readonly;
  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: readonly,
      controller: textEditingController,
      obscureText: obscureText,
      keyboardType: textInputType,
      decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(
              fontFamily: 'noto', fontSize: 10, color: Colors.grey.shade600),
          enabledBorder: border(),
          focusedBorder: border(borderColor: Color(0xff0163BE))),
    );
  }

  OutlineInputBorder border({Color borderColor = Colors.grey}) {
    return OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey.shade300,
        width: 1,
      ),
      borderRadius: BorderRadius.circular(10),
    );
  }
}
