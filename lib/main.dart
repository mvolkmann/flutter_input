import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'my_checkbox.dart';
import 'my_range_slider.dart';
import 'radio_buttons.dart';
import 'widget_extensions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

enum Sport { baseball, basketball, football, hockey }

class _MyHomePageState extends State<MyHomePage> {
  var favoriteSport = Sport.baseball;
  var like = false;
  var myRange = RangeValues(0, 100);
  var selectedDate = DateTime.now();

  CalendarDatePicker _buildCalendarDatePicker() => CalendarDatePicker(
        // Can start with display of days
        // in the initial month (.day; default) or
        // display of a range of years from which to pick (.year).
        //initialCalendarMode: DatePickerMode.year,

        // Initially selected date.
        initialDate: selectedDate,

        // Earliest date that can be selected.
        firstDate: DateTime.utc(1940, 1, 1),

        // Latest date that can be selected.
        lastDate: DateTime.utc(2099, 12, 31),

        onDateChanged: (dateTime) {
          print('selected $dateTime');
          setState(() {
            selectedDate = dateTime;
          });
        },
      );

  /*
  // This is one way to create a labelled checkbox.
  // I don't prefer this approach because tapping the text
  // to the left of the checkbox does not toggle it.
  Row _buildCheckboxRow() => Row(children: [
        Text('Like?'),
        Checkbox(
          value: like,
          //TODO: Why is the type of value "bool?"?
          onChanged: (value) => setState(() => like = value!),
        ),
      ]);
  */

  /*
  // Here is another way to implement _buildCheckboxRow
  // that uses CheckboxListTile.  I don't prefer that
  // because it takes all available width and
  // puts the title on the left and the checkbox on the right.
  CheckboxListTile _buildCheckboxRow() => CheckboxListTile(
        contentPadding: EdgeInsets.zero,
        title: Text('Like?'),
        value: like,
        onChanged: (value) => setState(() => like = value!),
      );
  */

  Widget _buildCheckboxRow() => MyCheckbox(
        label: 'Like?',
        value: like,
        onChanged: (value) => setState(() => like = value!),
      );

  Divider _buildDivider() => Divider(color: Colors.red);

  ElevatedButton _buildElevatedButton() => ElevatedButton(
        child: Text('Press Me'),
        onPressed: () => print('got ElevatedButton press'),
      );

  FloatingActionButton _buildFloatingActionButton() {
    return FloatingActionButton(
      child: Icon(Icons.thumb_up),
      onPressed: () => print('got FloatingActionButon press'),
    );

    // This creates a button that is an oval instead of a circle
    // and contains an Icon AND a label.
    /*
    return FloatingActionButton.extended(
      label: Text("I'm Floating"),
      icon: Icon(Icons.thumb_up),
      onPressed: () => print('got FloatingActionButon press'),
    );
    */
  }

  IconButton _buildIconButton() => IconButton(
        icon: Icon(Icons.save, color: Colors.green),
        onPressed: () => print('got IconButton press'),
      );

  OutlinedButton _buildOutlinedButton() => OutlinedButton(
        child: Text('OutlineButton'),
        onPressed: () => print('got OutlineButton press'),
      );

  /*
  // This is one way to create a set of radio buttons.
  // I don't prefer this approach because tapping the text
  // to the right of the radio buttons does not select them.
  Column _buildRadioButtons() {
    return Column(
        children: Sport.values.map<Widget>(
      (sport) {
        var radio = Radio<Sport>(
          value: sport,
          groupValue: favoriteSport,
          visualDensity: VisualDensity.compact,
          onChanged: (value) {
            setState(() {
              favoriteSport = sport;
            });
          },
        );
        return ListTile(
          contentPadding: EdgeInsets.all(0),
          // This reduces the space between rows
          // and makes leading and title smaller.
          dense: true,
          horizontalTitleGap: 0, // reduces space between leading and title
          leading: radio,
          //minLeadingWidth: 0, // no effect
          //minVerticalPadding: 0, // no effect
          // Tapping the title does not select the corresponding Radio.
          title: Text(describeEnum(sport)),
        );
      },
    ).toList());
  }
  */

  // This custom approach to creating radio buttons makes it so
  // tapping the text to the right of the radio buttons
  // selects the corresponding radio button.
  // It also simplifies creating radio buttons
  // from the values on an Enum.
  Widget _buildRadioButtons() {
    return RadioButtons(
      groupValue: favoriteSport,
      values: Sport.values,
      onChanged: (value) {
        setState(() => favoriteSport = value as Sport);
      },
    );
  }

  String doubleToIntString(double value) => value.round().toString();
  String rangeStart(RangeValues range) => doubleToIntString(range.start);
  String rangeEnd(RangeValues range) => doubleToIntString(range.end);

  Widget _buildRangeSlider() {
    return MyRangeSlider(
        divisions: 20,
        max: 100,
        values: myRange,
        onChanged: (RangeValues values) {
          print(values);
          setState(() => myRange = values);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Form(
          child: ListView(
            children: <Widget>[
              _buildDivider(),
              _buildCalendarDatePicker(),
              _buildDivider(),
              _buildCheckboxRow(),
              _buildDivider(),
              _buildElevatedButton(),
              _buildDivider(),
              _buildFloatingActionButton(),
              _buildDivider(),
              _buildIconButton(),
              _buildDivider(),
              _buildOutlinedButton(),
              _buildDivider(),
              _buildRadioButtons(),
              Text('Your favorite sport is ${describeEnum(favoriteSport)}.'),
              _buildDivider(),
              _buildRangeSlider(),
            ],
          ),
        ).pad(20),
      ),
    );
  }
}
