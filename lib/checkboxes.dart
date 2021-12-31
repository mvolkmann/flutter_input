import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'iterable_extension.dart';
import 'my_checkbox.dart';

/// This creates a set of radio buttons from a list of values.
/// The values can come from the values property of an enum.
class Checkboxes<T> extends StatelessWidget {
  final List<bool> values;
  final List<T> labels;
  final ValueChanged<List<bool>> onChanged;

  const Checkboxes({
    Key? key,
    required this.labels,
    required this.values,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var children = values
        .mapIndexed(
          (value, index) => MyCheckbox(
            label: describeEnum(labels[index]!),
            onChanged: (bool? value) {
              var newValues = [...values];
              newValues[index] = value!;
              onChanged(newValues);
            },
            value: value,
          ),
        )
        .toList();

    return Column(children: children);
  }
}
