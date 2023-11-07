import 'package:flutter/material.dart';

class TextForm extends StatelessWidget {

  final TextEditingController controller;
  final String text;
  const TextForm({super.key, required this.controller, required this.text});

  @override
  Widget build(BuildContext context) {
    return  TextField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8)
        ),
        hintText: text,

      ),
    );

  }
}
