import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MyDropdown<T> extends StatelessWidget {
  final T? value;
  final List<T> values;
  final ValueChanged<T?> onChanged;

  const MyDropdown({
    Key? key,
    required this.onChanged,
    required this.value,
    required this.values,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var items = values
        .map<DropdownMenuItem<T>>(
          (value) => DropdownMenuItem<T>(
            value: value,
            child: Text(describeEnum(value!)),
          ),
        )
        .toList();

    //TODO: How can you get this to only have the width required for the items?
    return SizedBox(
      child: DropdownButton<T>(
        isExpanded: false,
        items: items,
        onChanged: onChanged,
        value: value,
      ),
      width: 100,
    );
  }
}
