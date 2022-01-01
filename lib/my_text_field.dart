import 'package:flutter/material.dart';
import 'widget_extensions.dart';

class MyTextField extends StatefulWidget {
  final String hintText;
  final String initialValue;
  final String labelText;
  final Function(String) onChanged;

  const MyTextField({
    Key? key,
    this.hintText = '',
    this.initialValue = '',
    this.labelText = '',
    required this.onChanged,
  }) : super(key: key);

  @override
  _MyTextFieldState createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        // Note how "widget" is used to access
        // properties in the StatefulWidget above.
        hintText: widget.hintText,
        labelText: widget.labelText,
      ),
      initialValue: widget.initialValue,
      onChanged: (String value) {
        print('value = $value');
        widget.onChanged(value);
      },
    ).pad(10);
  }
}
