import 'package:flutter/material.dart';

// This improves on the provided RangeSlider widget
// by displaying the selected start and end values
// at the ends of the slider.
class MyRangeSlider extends StatelessWidget {
  final int? divisions;
  final double max;
  final double min;
  final RangeValues values;
  final ValueChanged<RangeValues> onChanged;

  const MyRangeSlider({
    Key? key,
    this.divisions, // times to divide range, not step
    this.max = 1.0,
    this.min = 0.0,
    required this.values,
    required this.onChanged,
  }) : super(key: key);

  String doubleToIntString(double value) => value.round().toString();
  String rangeStart(RangeValues range) => doubleToIntString(range.start);
  String rangeEnd(RangeValues range) => doubleToIntString(range.end);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(rangeStart(values)),
        Expanded(
          child: RangeSlider(
            values: values,
            min: min,
            max: max,
            divisions: divisions,
            labels: RangeLabels(
              rangeStart(values),
              rangeEnd(values),
            ),
            onChanged: onChanged,
          ),
        ),
        Text(rangeEnd(values)),
      ],
    );
  }
}
