import 'package:flutter/material.dart';
import 'widget_extensions.dart';

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
            child: Row(
              children: [
                Text(items[index]).expand(),
                Icon(Icons.menu, color: Colors.grey),
              ],
            ),
            index: index,
            key: Key(items[index]),
          );
        },
        itemCount: items.length,
        onReorder: (oldIndex, newIndex) {
          final item = items.removeAt(oldIndex);
          if (newIndex > oldIndex) newIndex--;
          items.insert(newIndex, item);
        },
      ),
    );
  }
}
