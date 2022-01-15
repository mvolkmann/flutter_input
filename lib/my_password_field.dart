import 'package:flutter/material.dart';
import 'widget_extensions.dart';

typedef ValidatorFn = String? Function(String?)?;

class MyPasswordField extends StatefulWidget {
  final String initialValue;
  final String labelText;
  final void Function(String) onChanged;
  final ValidatorFn validator;

  const MyPasswordField({
    Key? key,
    this.initialValue = '',
    this.labelText = '',
    this.validator,
    required this.onChanged,
  }) : super(key: key);

  @override
  _MyPasswordFieldState createState() => _MyPasswordFieldState();
}

class _MyPasswordFieldState extends State<MyPasswordField> {
  var obscure = true;

  @override
  Widget build(BuildContext context) {
    var validator = widget.validator;
    return TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: widget.labelText,
        suffixIcon: IconButton(
          icon: Icon(obscure ? Icons.visibility : Icons.visibility_off),
          onPressed: () {
            setState(() => obscure = !obscure);
          },
        ),
      ),
      initialValue: widget.initialValue,
      obscureText: obscure,
      onChanged: (String value) => widget.onChanged(value),
      validator: validator,
    ).vPad(10);
  }
}
