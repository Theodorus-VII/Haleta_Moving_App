import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BuildTextField extends StatefulWidget {
  final String labelText;
  final Icon? icon;
  final String hintText;
  final bool obscured;
  final TextEditingController controller;
  final bool readOnly;
  const BuildTextField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.hintText,
    this.icon,
    this.obscured = false,
    this.readOnly = false,
  });

  @override
  State<BuildTextField> createState() => _BuildTextFieldState(
      labelText: labelText,
      icon: icon,
      hintText: hintText,
      obscured: obscured,
      controller: controller,
      readOnly: readOnly,
      key: key);
}

class _BuildTextFieldState extends State<BuildTextField> {
  final String labelText;
  final Icon? icon;
  final String hintText;
  final bool obscured;
  final TextEditingController controller;
  final key;
  final bool readOnly;
  _BuildTextFieldState({
    required this.key,
    required this.controller,
    required this.labelText,
    required this.hintText,
    this.icon,
    this.obscured = false,
    this.readOnly = false,
  });

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    controller.text = (controller == null)?'':controller.text;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 25),
      child: Container(
        height: 42,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Form(
          key: key,
          child: TextFormField(
            readOnly: readOnly,
            controller: controller,
            obscureText: obscured,
            onSaved: (newValue) {
              setState(() {
                controller.text = ('$newValue');
              });
            },
            style: const TextStyle(
                height: 0.7,
                backgroundColor: Colors.white,
                fontWeight: FontWeight.bold),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14.0),
              ),
              labelText: labelText,
              hintText: hintText,
              hintStyle: TextStyle(fontWeight: FontWeight.w400),
              prefixIcon: icon,
            ),
          ),
        ),
      ),
    );
  }
}
