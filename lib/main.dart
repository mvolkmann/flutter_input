import 'package:flutter/material.dart';

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

class _MyHomePageState extends State<MyHomePage> {
  var like = false;
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

  Row _buildCheckboxRow() => Row(children: [
        Text('Like?'),
        Checkbox(
          value: like,
          onChanged: (value) {
            //TODO: Why is the type of value "bool?"?
            setState(() {
              like = value!;
            });
          },
        ),
      ]);

  Divider _buildDivider() => Divider(color: Colors.red);

  ElevatedButton _buildElevatedButton() => ElevatedButton(
        child: Text('Press Me'),
        onPressed: () => print('got press'),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Form(
          child: Column(
            children: <Widget>[
              _buildCalendarDatePicker(),
              _buildDivider(),
              _buildCheckboxRow(),
              _buildDivider(),
              _buildElevatedButton(),
            ],
          ),
        ),
      ),
    );
  }
}
