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

enum Sport { baseball, basketball, football, hockey }

class _MyHomePageState extends State<MyHomePage> {
  var favoriteSport;
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
        onPressed: () => print('got ElevatedButton press'),
      );

  FloatingActionButton _buildFloatingActionButton() {
    return FloatingActionButton(
      child: Icon(Icons.thumb_up),
      onPressed: () => print('got FloatingActionButon press'),
    );
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

  Column _buildRadioButtons() => Column(
        children: Sport.values
            .map<Widget>(
              (sport) => ListTile(
                leading: Radio<Sport>(
                  value: sport,
                  groupValue: favoriteSport,
                  onChanged: (value) {
                    setState(() {
                      favoriteSport = sport;
                    });
                  },
                ),
                title: Text(sport.toString()),
              ),
            )
            .toList(),
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
              _buildDivider(),
              _buildFloatingActionButton(),
              _buildDivider(),
              _buildIconButton(),
              _buildDivider(),
              _buildOutlinedButton(),
              _buildDivider(),
              _buildRadioButtons(),
            ],
          ),
        ),
      ),
    );
  }
}
