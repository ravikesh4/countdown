import 'package:flutter/material.dart';
import 'package:timer/count_down_timer_page.dart';
import 'package:timer/count_up_timer_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Homepage(),
    );
  }
}

class Homepage extends StatefulWidget {
  const Homepage({Key key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  bool hasTimerStopped = false;
  @override
  Widget build(BuildContext context) {
    return  Container(
      width: 60.0,
      padding: EdgeInsets.only(top: 3.0, right: 4.0),
      child: CountDownTimer(
        secondsRemaining: 3620,
        whenTimeExpires: () {
          setState(() {
            hasTimerStopped = true;
          });
        },
        countDownTimerStyle: TextStyle(
            color: Color(0XFFf5a623),
            fontSize: 17.0,
            height: 1.2),
      ),
    );
  }
}
