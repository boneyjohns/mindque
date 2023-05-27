import 'package:flutter/material.dart';

class Mytextformfield extends StatelessWidget {
  const Mytextformfield(
      {super.key,
      required this.text,
      required this.preicon,
      required this.mycontroller,
      required this.hide,
      this.validator,
      this.onSave,
      this.keyboardtype});
  final String text;
  final IconData preicon;
  final TextEditingController mycontroller;
  final TextInputType? keyboardtype;
  final bool hide;
  final String? Function(String?)? validator;
  final Function(String?)? onSave;
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 30),
        child: TextFormField(
          validator: validator,
          keyboardType: keyboardtype,
          controller: mycontroller,
          obscureText: hide,
          onSaved: onSave,
          decoration: InputDecoration(
            labelText: text,
            enabledBorder: const OutlineInputBorder(),
            prefixIcon: Icon(preicon),
          ),
        ));
  }
}
