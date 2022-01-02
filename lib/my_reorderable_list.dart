import 'package:flutter/material.dart';

class MyReorderableList extends StatelessWidget {
  final List<String> items;

  const MyReorderableList({
    Key? key,
    required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //TODO: Is SizedBox needed?
    return SizedBox(
      height: 100,
      child: ReorderableList(
        itemBuilder: (context, index) {
          return ReorderableDragStartListener(
            child: Text(items[index]),
            index: index,
            key: Key(items[index]),
          );
        },
        itemCount: items.length,
        onReorder: (oldIndex, newIndex) {
          //TODO: This logic is not correct!
          final item = items.removeAt(oldIndex);
          items.insert(newIndex, item);
        },
      ),
    );
  }
}
