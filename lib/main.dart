import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:user_details/class/class.dart';
import 'package:user_details/screens/form.dart';
import 'package:user_details/screens/home_screen.dart';


Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(UserDetailsAdapter());
  await Hive.openBox<UserDetails>('userDetail');
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
      home: const HiveUser(),
      debugShowCheckedModeBanner: false,
    );
  }
}
