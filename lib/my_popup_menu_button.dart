import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MyPopupMenuButton<T extends Object> extends StatelessWidget {
  final ValueChanged<T> onSelected;
  final T value;
  // PopupMenuButton does not support
  // having a PopupMenuItem whose value is null!
  final List<T> values;

  const MyPopupMenuButton({
    Key? key,
    required this.onSelected,
    required this.value,
    required this.values,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var items = values
        .map<PopupMenuItem<T>>(
          (T value) => PopupMenuItem<T>(
            child: Text(describeEnum(value)),
            value: value,
          ),
        )
        .toList();
    return Row(
      children: [
        Text(describeEnum(value)),
        PopupMenuButton<T>(
          icon: Icon(Icons.more_vert), // uses horizontal ellipsis by default
          itemBuilder: (BuildContext context) => items,
          onSelected: onSelected,
        ),
      ],
    );
  }
}
