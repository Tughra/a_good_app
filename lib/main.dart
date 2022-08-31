import 'dart:developer';

import 'package:a_good_app/core/notification_service.dart';
import 'package:a_good_app/firebase_database_helper.dart';
import 'package:a_good_app/screen/wrapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:workmanager/workmanager.dart';

import 'services/auth_service.dart';

void callbackDispatcher() {
  Workmanager().executeTask((taskName, inputData) async {
    if (taskName == "trigger") {

        LocalNotificationService.instance.showNotification(
            hashcode: 2, payload: "payload"
            , title: "WorkManager",
            body: "WorkManager is triggered"
        );
      debugPrint("**********-**********");
    }
    return Future.value(true);
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Workmanager().cancelAll().then((value) {
    Workmanager().initialize(callbackDispatcher, isInDebugMode: true).then((
        value) => Workmanager().registerOneOffTask("1", "trigger"));
  });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: StreamProvider<User?>.value(
          initialData: null,
          value: AuthService().userChanges,
          child: const Wrapper()),
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
  int _counter = 0;
  final FirebaseDataBaseHelper _helper = FirebaseDataBaseHelper();

  @override
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme
                  .of(context)
                  .textTheme
                  .headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _helper.getFirst();
          print("asdsad");
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
