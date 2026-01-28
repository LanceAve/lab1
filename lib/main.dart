import 'dart:async'; // timer functionality
import 'package:flutter/material.dart'; // flutter material nonsense
import 'package:flutter/services.dart'; // system UI modification

void main() => runApp(const LabN1App());

class LabN1App extends StatelessWidget {
  const LabN1App({super.key});

  @override
  Widget build(BuildContext context) {
    // set status bar color and icon brightness
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.blue, // Status bar color
        statusBarIconBrightness: Brightness.dark, // Light icons for status bar
      ),
    );

    return MaterialApp(
      home: ScaffoldLab(),
      debugShowCheckedModeBanner: false, // remove debug label
    );
  }
}

// initialize stateful widget class
class ScaffoldLab extends StatefulWidget {
  const ScaffoldLab({super.key});

  @override
  State<ScaffoldLab> createState() => _ScaffoldState();
}

// then implement said class using State<>
class _ScaffoldState extends State<ScaffoldLab> {
  Timer? _timer;
  int _seconds = 0;

  // timer function to start/stop timer
  void _toggleTimer() {
    const oneSecond = Duration(seconds: 1);

    // toggle timer state
    setState(() {
      // check if timer is active
      if (_timer?.isActive ?? false) {
        // cancel timer if active
        _timer?.cancel();

        // start timer if not active
      } else {
        // reset timer count
        setState(() {
          _seconds = 0;
        });

        // start new timer that increments every second
        _timer = Timer.periodic(oneSecond, (timer) {
          setState(() {
            _seconds++;
          });
        });
      }
    });
  }

  // clean up timer on dispose
  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Lab N1',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue, // keep AppBar blue

        systemOverlayStyle: const SystemUiOverlayStyle(
          // status bar HEX value obtained using Digital Color Meter app
          statusBarColor: Color(
            0xFF1976D2,
          ), // make AppBar not override status bar
        ),
      ),

      // body with centered column for timer display
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // timer label
            const Text(
              'Timer:',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),

            // timer text display
            Text(
              '$_seconds',
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),

      // floating action button that changes color and icon based on timer state
      floatingActionButton: Container(
        width: 70,
        height: 70,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: (_timer?.isActive ?? false) ? Colors.red : Colors.blue,
        ),

        // center the icon button within the container
        child: IconButton(
          onPressed: _toggleTimer,
          icon: Icon(
            (_timer?.isActive ?? false)
                ? Icons.stop
                : Icons.play_circle_outline,
            color: Colors.white,
            size: 36,
          ),
        ),
      ),

      // position floating action button in the center docked location
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      // bottom app bar with notch for floating action button
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Container(height: 50.0),
      ),
    );
  }
}
