// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:ufstestprobprob/presentation/homescreen/controller/homescreencontroller.dart';

import 'presentation/homescreen/view/homescreen.dart';

Future<void> main() async {
  await Hive.initFlutter();
  var box = await Hive.openBox('products');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => HomeScreenController(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}
