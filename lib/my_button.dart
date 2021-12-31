import 'package:flutter/material.dart';

// Simplifies creating an ElevatedButton that only contains a Text widget.
class MyButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  const MyButton({
    Key? key,
    required this.onPressed,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      key: key,
      child: Text(text),
      onPressed: onPressed,
    );
  }
}
