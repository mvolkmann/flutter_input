import 'package:flutter/material.dart';

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
