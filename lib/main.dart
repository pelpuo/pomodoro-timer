import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:pomodoro/screens/infoScreen.dart';
import 'package:pomodoro/screens/settingsScreen.dart';
import 'package:pomodoro/screens/timerScreen.dart';
import 'package:pomodoro/providers/timer_provider.dart';
import 'package:pomodoro/utilities/notify.dart';
import 'package:pomodoro/utilities/persist_data.dart';
import 'package:provider/provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await persistVals.init();
  await Notify().init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TimerProvider>(
      create: (context) => TimerProvider(),
      child: Consumer<TimerProvider>(
        builder: (context, timerProvider, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Pomodoro',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: Home(),
        ),
      ),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  final screens = [timerScreen(), settingsScreen(), infoScreen()];

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    Provider.of<TimerProvider>(context, listen: false).loadTimerSettings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text("Pomodoro timer")),
      body: IndexedStack(
        children: screens,
        index: _currentIndex,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF0C2C41),
        currentIndex: _currentIndex,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: const Color(0xFF34DADA),
        unselectedItemColor: const Color(0xFF1A5074),
        elevation: 0,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.access_time_outlined), label: "timer"),
          BottomNavigationBarItem(icon: Icon(Icons.tune), label: "settings"),
          BottomNavigationBarItem(
              icon: Icon(Icons.info_outline_rounded), label: "info"),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
