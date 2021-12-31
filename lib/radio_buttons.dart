import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'my_radio.dart';

/// This creates a set of radio buttons from a list of values.
/// The values can come from the values property of an enum.
class RadioButtons<T> extends StatelessWidget {
  final T? groupValue;
  final List<T> values;
  final ValueChanged<Object?> onChanged;

  const RadioButtons({
    Key? key,
    required this.groupValue,
    required this.values,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: values
          .map<Widget>((value) => MyRadio<T>(
              groupValue: groupValue,
              label: describeEnum(value!),
              onChanged: onChanged,
              value: value))
          .toList(),
    );
  }
}
