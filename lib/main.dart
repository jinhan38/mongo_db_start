import 'package:flutter/material.dart';
import 'package:mongo_db_start/MongoDbDisplay.dart';
import 'package:mongo_db_start/dbHelper/mongodb.dart';
import 'package:mongo_db_start/insert.dart';
import 'package:mongo_db_start/mongo_db_update.dart';
import 'package:mongo_db_start/query.dart';

import 'delete.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MongoDatabase.connect();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const QueryDatabase(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Text("hello"),
      ),
    );
  }
}
