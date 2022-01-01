import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MyPopupMenuButton<T> extends StatelessWidget {
  final ValueChanged<T> onSelected;
  final T value;
  final List<T> values;

  const MyPopupMenuButton({
    Key? key,
    required this.onSelected,
    required this.value,
    required this.values,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (value != null) Text(describeEnum(value!)),
        PopupMenuButton(
          itemBuilder: (BuildContext context) => values
              .map<PopupMenuItem<T>>(
                (T value) => PopupMenuItem<T>(
                  child: Text(describeEnum(value!)),
                  value: value,
                ),
              )
              .toList(),
          onSelected: onSelected,
        ),
      ],
    );
  }
}
