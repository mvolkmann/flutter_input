import 'package:flutter/material.dart';

// There seems to be a bug in Autocomplete where an exception is thrown
// related to a KeyUpEvent if the first selection is made by typing characters,
// moving to an option with arrows keys, and pressing return to select it.
class MyAutocomplete extends StatelessWidget {
  final String? initialValue;
  final AutocompleteOnSelected<String>? onSelected;
  final Iterable<String> words;

  const MyAutocomplete({
    Key? key,
    this.initialValue,
    required this.onSelected,
    required this.words,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Autocomplete<String>(
      optionsBuilder: (TextEditingValue tev) => tev.text == ''
          ? <String>[]
          : words.where(
              (String word) => word.contains(tev.text.toLowerCase()),
            ),
      onSelected: onSelected,
    );
  }
}
