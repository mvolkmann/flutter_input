import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MyPopupMenuButton<T> extends StatelessWidget {
  final ValueChanged<T?> onSelected;
  final T? value;
  final List<T> values;

  const MyPopupMenuButton({
    Key? key,
    required this.onSelected,
    required this.value,
    required this.values,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('build: value = $value');
    var items = values
        .map<PopupMenuItem<T?>>(
          (T value) => PopupMenuItem<T>(
            child: Text(describeEnum(value!)),
            value: value,
          ),
        )
        .toList();
    //TODO: Why is onSelected not called when this is selected?
    items.insert(0, PopupMenuItem(child: Text('None'), value: null));
    return Row(
      children: [
        //if (value != null) Text(describeEnum(value!)),
        Text(value == null ? 'None' : describeEnum(value!)),
        PopupMenuButton<T?>(
          icon: Icon(Icons.more_vert), // horizontal ellipsis by default
          itemBuilder: (BuildContext context) => items,
          onSelected: onSelected,
        ),
      ],
    );
  }
}
