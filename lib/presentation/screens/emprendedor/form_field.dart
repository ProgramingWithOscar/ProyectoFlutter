
import 'package:flutter/material.dart';

class FormField extends StatelessWidget {
  final TextEditingController name;
  bool filled;
  final String hinText;

  FormField(
      {super.key,
      required this.name,
      required this.hinText,
      required this.filled});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(13),
      child: TextFormField(
        controller: name,
        decoration: InputDecoration(
          filled: filled,
          fillColor: Colors.white,
          hintText: hinText,
        ),
      ),
    );
  }
}
