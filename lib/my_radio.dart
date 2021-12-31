import 'package:flutter/material.dart';

typedef StringCallback = void Function(String value);

/// This is similar to wrapping the Flutter Radio widget in a ListTile,
/// but it has the advantage that tapping the label after the radio button
/// also selects the radio button.
/// The RadioButtons widget uses this.
class MyRadio<T> extends StatelessWidget {
  final T? groupValue;
  final String label;
  final ValueChanged<T?>? onChanged;
  final T value;

  const MyRadio({
    Key? key,
    required this.groupValue,
    required this.label,
    required this.onChanged,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Radio(value: value, groupValue: groupValue, onChanged: onChanged),
      TextButton(child: Text(label), onPressed: () => onChanged!(value))
    ]);
  }
}
