import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'checkboxes.dart';
import 'dismiss_keyboard.dart';
import 'iterable_extension.dart';
import 'my_autocomplete.dart';
import 'my_button.dart';
import 'my_checkbox.dart';
import 'my_dropdown.dart';
import 'my_password_field.dart';
import 'my_popup_menu_button.dart';
import 'my_range_slider.dart';
import 'my_reorderable_list.dart';
import 'my_slider.dart';
import 'my_text_field.dart';
import 'my_switch.dart';
import 'my_toggle_buttons.dart';
import 'radio_buttons.dart';
import 'widget_extensions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DismissKeyboard(
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const Home(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class Home extends StatefulWidget {
  final String title;

  const Home({Key? key, required this.title}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

enum Season { spring, summer, fall, winter }
enum Sport { none, baseball, basketball, football, hockey }

class _HomeState extends State<Home> {
  var alignment = 'left';
  var favoriteSport = Sport.none;
  var firstName = '';
  var isExpanded = false;
  var isSelected = [false, false, false];
  var like = false;
  var lightSwitch = false;
  var myRange = RangeValues(0, 100);
  var password = '';
  //var scrollController = ScrollController();
  var selectedDate = DateTime.now();
  Season? selectedSeason;
  String selectedWord = '';
  var sliderValue = 0.0;
  var yearDate = DateTime.now();

  static const words = [
    'apple',
    'apricot',
    'banana',
    'blueberry',
    'blackberry',
    'cherry',
    'grape',
    'grapefruit',
    'lemon',
    'orange',
    'peach',
    'plum',
    'watermelon'
  ];

  // This creates a list of false values, one for each Sport enum value.
  var selectedSports = Sport.values.map<bool>((_) => false).toList();

  Widget _buildAutocomplete() => MyAutocomplete(
        initialValue: selectedWord,
        onSelected: (value) => setState(() => selectedWord = value),
        words: words,
      );

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

  // This custom approach to creating checkboxes makes it so
  // tapping the text to the left of the checkboxes
  // toggles the corresponding checkbox.
  // It also simplifies creating checkboxes
  // from the values on an Enum.
  Checkboxes<Sport> _buildCheckboxes() {
    return Checkboxes(
      labels: Sport.values,
      values: selectedSports,
      onChanged: (values) {
        setState(() => selectedSports = values);
      },
    );
  }

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

  Widget _buildCupertinoDatePicker() {
    return Container(
      child: CupertinoDatePicker(
        initialDateTime: DateTime.now(),
        minimumYear: 1990,
        maximumYear: 2030,

        // Will get "Failed assert" after changing this.
        // Restart the app to resolve.
        //mode: CupertinoDatePickerMode.dateAndTime, // default
        mode: CupertinoDatePickerMode.date,
        //mode: CupertinoDatePickerMode.time,

        onDateTimeChanged: (DateTime value) {
          print('You selected $value');
        },
      ),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.red),
      ),
      height: 200,
    );
  }

  Widget _buildCupertinoPicker() {
    return Container(
      child: CupertinoPicker.builder(
        childCount: words.length,
        itemBuilder: (context, index) => Text(words[index]),
        itemExtent: 30, // height of each item
        onSelectedItemChanged: (int index) {
          // This fires while dragging, not just when released.
          print('You selected ${words[index]}');
        },
      ),
      // This makes it clear the vertical space that is occupied.
      decoration: BoxDecoration(
        border: Border.all(color: Colors.red),
      ),
      height: 150, // height of wheel; affects # of visible items
    );
  }

  Divider _buildDivider() => Divider(color: Colors.red);

  Widget _buildDropdownButton() => MyDropdown<Season>(
        value: selectedSeason,
        values: Season.values,
        onChanged: (season) => setState(() => selectedSeason = season!),
      );

  Widget _buildElevatedButton() => Tooltip(
        child: ElevatedButton(
          child: Text('ElevatedButton'),
          onPressed: () => print('got ElevatedButton press'),
        ),
        message: 'I am a tooltip!',
        preferBelow: false,
      );

  FloatingActionButton _buildFloatingActionButton() {
    // When this is used as the floatingActionButton argument to a Scaffold,
    // it is placed in the lower-right corner.
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
        tooltip: 'This is a tooltip.',
      );

  OutlinedButton _buildOutlinedButton() => OutlinedButton(
        child: Text('OutlineButton'),
        onPressed: () => print('got OutlineButton press'),
      );

  Widget _buildPasswordField() {
    return MyPasswordField(
      labelText: 'Password',
      onChanged: (value) => setState(() => password = value),
    );
  }

  /*
  Widget _buildPopupMenuButton() => PopupMenuButton(
        itemBuilder: (BuildContext context) => Sport.values
            .map<PopupMenuItem<Sport>>(
              (Sport sport) => PopupMenuItem<Sport>(
                child: Text(describeEnum(sport)),
                value: sport,
              ),
            )
            .toList(),
        onSelected: (Sport? value) => setState(
          () => selectedSport = value!,
        ),
      );
  */
  Widget _buildPopupMenuButton() => MyPopupMenuButton<Sport>(
        onSelected: (Sport value) => setState(() => favoriteSport = value),
        value: favoriteSport,
        values: Sport.values,
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

  Widget _buildRangeSlider() {
    return MyRangeSlider(
        divisions: 20,
        max: 100,
        values: myRange,
        onChanged: (RangeValues values) {
          setState(() => myRange = values);
        });
  }

  Widget _buildReorderableList() {
    var items = ['apple', 'banana', 'cherry', 'grape'];
    return MyReorderableList(items: items);
  }

  Widget _buildSlider() {
    return MySlider(
        divisions: 20,
        max: 100,
        value: sliderValue,
        onChanged: (double value) {
          setState(() => sliderValue = value);
        });
  }

  Widget _buildSwitch() {
    return MySwitch(
      offLabel: 'Light Off',
      onLabel: 'Light On',
      onChanged: (value) => setState(() => lightSwitch = value),
      value: lightSwitch,
    );
  }

  Widget _buildText() => Tooltip(
        child: Text('I have a tooltip.'),
        message: 'Now you see the tooltip.',
        triggerMode: TooltipTriggerMode.tap,
      );

  Widget _buildTextField() {
    return MyTextField(
      hintText: 'Enter your first name.',
      initialValue: firstName,
      labelText: 'First Name',
      onChanged: (value) => setState(() => firstName = value),
    );
  }

  Widget _buildToggleButtons() {
    return MyToggleButtons(
      icons: [
        Icons.align_horizontal_left,
        Icons.align_horizontal_center,
        Icons.align_horizontal_right,
      ],
      labels: ['Left', 'Center', 'Right'],
      value: alignment,
      values: ['left', 'center', 'right'],
      onChanged: (value) => setState(() => alignment = value),
    );
  }

  Widget _buildYearPicker() {
    //TODO: This isn't working properly and I can find an example online.
    return SizedBox(
      height: 100,
      width: 200,
      child: YearPicker(
        // Earliest date from which a year can be selected.
        firstDate: DateTime.utc(1940, 1, 1),

        // Latest date from which a year can be selected.
        lastDate: DateTime.utc(2099, 12, 31),

        initialDate: DateTime.now(),

        selectedDate: yearDate,

        onChanged: (dateTime) {
          print('selected $dateTime');
          setState(() {
            yearDate = dateTime;
          });
        },
      ),
    );
  }

  Iterable<String> getSelectedSportNames() {
    return Sport.values
        .whereIndexed((sport, index) => selectedSports[index])
        .map(describeEnum);
  }

  /*
  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      // Removes focus from the TextField that
      // triggered the on-screen keyboard to open.
      FocusScope.of(context).requestFocus(FocusNode());
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
  */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.ac_unit),
        onPressed: () => print('got press'),
      ),
      body: Center(
        child: Form(
          child: ListView(
            //controller: scrollController,
            children: <Widget>[
              _buildCupertinoDatePicker(),
              _buildCupertinoPicker(),
              _buildDivider(),

              ExpandIcon(
                  isExpanded: isExpanded,
                  onPressed: (_) {
                    setState(() => isExpanded = !isExpanded);
                  }),
              AnimatedContainer(
                child: Text('I am showing!'),
                duration: Duration(milliseconds: 500),
                curve: Curves.easeInOut,
                height: isExpanded ? 20 : 0,
              ),
              _buildDivider(),

              _buildPasswordField(),
              _buildDivider(),

              _buildReorderableList(),
              _buildDivider(),

              _buildAutocomplete(),
              if (selectedWord.isNotEmpty)
                Text('selected word is $selectedWord'),
              _buildDivider(),

              BackButton(
                //color: Colors.green,
                onPressed: () => print('got BackButton press'),
              ),
              CloseButton(
                color: Colors.red,
                onPressed: () => print('got CloseButton press'),
              ),
              _buildDivider(),

              _buildCalendarDatePicker(),
              _buildDivider(),

              _buildCheckboxRow(),
              _buildDivider(),

              _buildCheckboxes(),
              Text('Selected sports: ${getSelectedSportNames()}'),
              _buildDivider(),

              _buildDropdownButton(),
              Text('Selected season is $selectedSeason.'),
              _buildDivider(),

              // This requires manually creating
              // a Text widget for the common case
              // and it's width matches its parent.
              _buildElevatedButton(),
              // This creates a Text widget and
              // an ElevatedButton that uses it.
              MyButton(
                text: 'MyButton',
                onPressed: () => print('got MyButton Press'),
              ).row, // width will match parent without this
              _buildDivider(),

              _buildFloatingActionButton(),
              _buildDivider(),

              _buildIconButton(),
              _buildDivider(),

              _buildOutlinedButton(),
              _buildDivider(),

              _buildPopupMenuButton(),
              _buildDivider(),

              _buildRadioButtons(),
              Text('Favorite sport is ${describeEnum(favoriteSport)}.'),
              _buildDivider(),

              _buildRangeSlider(),
              _buildDivider(),

              _buildSlider(),
              _buildDivider(),

              _buildSwitch(),
              _buildDivider(),

              _buildText(),
              _buildDivider(),

              _buildTextField(),
              if (firstName.isNotEmpty) Text('Hello, $firstName!'),
              _buildDivider(),

              _buildToggleButtons(),
              Text('Selected alignment: $alignment'),

              //_buildDivider(),
              //_buildYearPicker(),
            ],
          ),
        ).pad(20),
      ),
    );
  }
}
