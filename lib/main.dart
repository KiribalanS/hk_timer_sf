import 'package:flutter/material.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:duration_picker/duration_picker.dart';
import 'package:flutter/services.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Circular Countdown Timer Demo',
      theme: ThemeData(
        fontFamily: 'Digital',
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final CountDownController _controller = CountDownController();
  Duration _pickedDuration = const Duration(seconds: 30);
  int _duration = 30;
  bool showTimer = false;
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      body: GestureDetector(
        onDoubleTap: () {
          setState(() {
            showTimer = !showTimer;
          });
        },
        child: Container(
          height: mediaQuery.height,
          width: mediaQuery.width,
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage("assets/removed.jpeg"),
            ),
          ),
          child: showTimer
              ? Container(
                  color: Colors.transparent.withOpacity(0.4),
                  child: Center(
                    child: CircularCountDownTimer(
                      isTimerTextShown: true,
                      timeFormatterFunction:
                          (defaultFormatterFunction, duration) {
                        return duration.inSeconds;
                      },
                      textStyle: TextStyle(
                        color: Colors.blue.shade800,
                        fontSize: 70,
                      ),
                      onComplete: () {
                        setState(() {
                          showTimer = !showTimer;
                        });
                      },
                      isReverse: true,
                      onChange: (value) {},
                      controller: _controller,
                      width: mediaQuery.width * .60,
                      height: mediaQuery.height * .60,
                      strokeWidth: 15,
                      duration: _duration,
                      fillColor: Colors.blue.shade800,
                      ringColor: Colors.green.shade600,
                    ),
                  ),
                )
              : Stack(
                  children: [
                    Center(
                      child: DurationPicker(
                        height: mediaQuery.height * 0.5,
                        width: mediaQuery.width * 0.5,
                        duration: _pickedDuration,
                        snapToMins: 5,
                        baseUnit: BaseUnit.second,
                        onChange: (val) {
                          setState(() {
                            if (val.inSeconds <= 500) {
                              _pickedDuration = val;
                            }
                            _duration = _pickedDuration.inSeconds.toInt();
                          });
                        },
                      ),
                    ),
                    Center(
                        child: CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.white,
                      child: Text(
                        _pickedDuration.inSeconds.toString(),
                        style: const TextStyle(
                          color: Colors.deepPurple,
                          fontSize: 25,
                        ),
                      ),
                    )),
                  ],
                ),
        ),
      ),
    );
  }
}
