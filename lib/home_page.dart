import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  Timer _timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        formattedDate = DateFormat('kk:mm').format(DateTime.now());
      });
    });
  }

  void _startTimer() {
    _counter = _counter;
    if (_timer != null) {
      _timer.cancel();
    }
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_counter > 0) {
          _counter--;
        } else {
          _timer.cancel();
        }
      });
    });
  }

  void _pauseCountDown() {
    _timer.cancel();
  }

  void _resetCountDown() {
    setState(() {
      _counter = 0;
    });
  }

  DateTime selectedDate = DateTime.now();
  var differenceInDays = 0;
  String formattedDate = DateFormat('kk:mm:ss').format(DateTime.now());

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));
    DateTime dateTimeNow = DateTime.now();
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        _counter = selectedDate.difference(dateTimeNow).inSeconds;
      });
  }

  static String formatDuration(Duration d) {
    var seconds = d.inSeconds;
    final days = seconds ~/ Duration.secondsPerDay;
    seconds -= days * Duration.secondsPerDay;
    final hours = seconds ~/ Duration.secondsPerHour;
    seconds -= hours * Duration.secondsPerHour;
    final minutes = seconds ~/ Duration.secondsPerMinute;
    seconds -= minutes * Duration.secondsPerMinute;

    final List<String> tokens = [];
    if (days != 0) {
      tokens.add('${days}d');
    }
    if (tokens.isNotEmpty || hours != 0) {
      tokens.add('${hours}h');
    }
    if (tokens.isNotEmpty || minutes != 0) {
      tokens.add('${minutes}m');
    }
    tokens.add('${seconds}s');

    return tokens.join(':');
  }

  TimeOfDay _time = TimeOfDay(hour: 7, minute: 15);
  DateTime selectedTime =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  void _selectTime() async {
    final TimeOfDay newTime = await showTimePicker(
      context: context,
      initialTime: _time,
    );
    if (newTime != null) {
      setState(() {
        _time = newTime;
        print('selectd time $selectedTime');
        print('compare time ${DateTime(_time.hour, _time.minute)}');
        _counter = selectedTime
            .difference(DateTime(_time.hour, _time.minute))
            .inSeconds;
      });
    }
  }

  bool _switchValue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Timer App"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CupertinoSwitch(
              value: _switchValue,
              onChanged: (value) {
                setState(() {
                  _switchValue = value;
                  if (_switchValue == true) {
                    _counter = DateTime.now()
                        .add(Duration(minutes: 20))
                        .difference(DateTime.now())
                        .inSeconds;
                    _startTimer();
                  } else {
                    _counter = 0;
                  }
                });
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                'Add 20 Minutes Countdown',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            (_counter > 0)
                ? Text("")
                : Text(
                    "DONE!",
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                'Countdown: ${formatDuration(Duration(seconds: _counter))}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                'Current time: ${formattedDate}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: _selectTime,
              child: Text('SELECT TIME'),
            ),
            SizedBox(height: 8),
            Text(
              'Selected time: ${_time.format(context)}',
            ),
            Text("${selectedDate.toLocal()}".split(' ')[0]),
            SizedBox(
              height: 20.0,
            ),
            RaisedButton(
              onPressed: () => _selectDate(context),
              child: Text('Select date'),
            ),
            RaisedButton(
              onPressed: () {
                DatePicker.showDateTimePicker(context, showTitleActions: true,
                onChanged: (date) {
                print('change $date in time zone ' +
                date.timeZoneOffset.inHours.toString());
                }, onConfirm: (date) {
                print('confirm $date');
                },
                currentTime: DateTime.now(),
                locale: LocaleType.en);
              },
              child: Text('Select date and time'),
            ),
            RaisedButton(
              onPressed: () => _startTimer(),
              child: Text(
                "Start",
              ),
              color: Colors.blue,
            ),
            RaisedButton(
              onPressed: () => _pauseCountDown(),
              child: Text("Pause"),
              color: Colors.yellow,
            ),
            RaisedButton(
              onPressed: () => _resetCountDown(),
              child: Text("Reset"),
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}
