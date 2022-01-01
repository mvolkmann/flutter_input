import 'package:flutter/material.dart';
import 'iterable_extension.dart';
import 'widget_extensions.dart';

class MyToggleButtons<T> extends StatelessWidget {
  final T? value;
  final List<IconData>? icons;
  final List<String>? labels;
  final List<String> values;
  final ValueChanged<String> onChanged;

  const MyToggleButtons({
    Key? key,
    this.icons,
    this.labels,
    required this.onChanged,
    required this.value,
    required this.values,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isSelected = values
        .mapIndexed<bool>(
          (v, index) => v == value,
        )
        .toList();
    var children = values
        .mapIndexed<Widget>(
          (value, index) => Column(
            children: [
              if (icons != null) Icon(icons![index]),
              if (labels != null) Text(labels![index]),
            ],
          ).pad(10),
        )
        .toList();

    return ToggleButtons(
      borderRadius: BorderRadius.circular(10),
      borderWidth: 2,
      children: children,
      isSelected: isSelected,
      onPressed: (int index) {
        onChanged(values[index]);
      },
    );
  }
}
