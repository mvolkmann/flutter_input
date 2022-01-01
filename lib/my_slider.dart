import 'package:flutter/material.dart';

// This improves on the provided Slider widget
// by displaying the selected start and end values
// at the ends of the slider.
class MySlider extends StatelessWidget {
  final int? divisions;
  final double max;
  final double min;
  final double value;
  final ValueChanged<double> onChanged;

  const MySlider({
    Key? key,
    this.divisions, // times to divide range, not step
    this.max = 1.0,
    this.min = 0.0,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  String doubleToIntString(double value) => value.round().toString();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Slider(
            divisions: divisions,
            label: doubleToIntString(value),
            max: max,
            min: min,
            onChanged: onChanged,
            value: value,
          ),
        ),
        Text(doubleToIntString(value)),
      ],
    );
  }
}
