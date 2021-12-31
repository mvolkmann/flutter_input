import 'package:flutter/material.dart';

typedef StringCallback = void Function(String value);

/// This is similar to wrapping the Flutter Checkbox widget in a ListTile,
/// but it has the advantage that tapping the label after the checkbox
/// also toggles the checkbox.
/// The Checkboxes widget uses this.
class MyCheckbox extends StatelessWidget {
  final String label;
  final ValueChanged<bool?>? onChanged;
  final bool value;

  const MyCheckbox({
    Key? key,
    required this.label,
    required this.onChanged,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      TextButton(child: Text(label), onPressed: () => onChanged!(!value)),
      Checkbox(value: value, onChanged: onChanged),
    ]);
  }
}
