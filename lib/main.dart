import 'package:flutter/material.dart';
import 'package:slide_countdown_clock/slide_countdown_clock.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Counter App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  int hours = 40;

  DateTime selectedDate = DateTime.now();
  var differenceInDays = 0;
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
        differenceInDays = selectedDate.difference(dateTimeNow).inDays;
        print(differenceInDays);
        counter(differenceInDays);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key:_scaffoldKey,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("${selectedDate.toLocal()}".split(' ')[0]),
            SizedBox(
              height: 20.0,
            ),
            RaisedButton(
              onPressed: () => _selectDate(context),
              child: Text('Select date'),
            ),
            Text('CLock 1'),
            counter(differenceInDays),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        // onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget counter(int differenceInDays) {
    return SlideCountdownClock(

      duration: Duration(days: differenceInDays),
      shouldShowDays: true,
      slideDirection: SlideDirection.Up,
      separator: ':',
      textStyle: TextStyle(
        fontSize: 40,
      ),
    );
  }
}
