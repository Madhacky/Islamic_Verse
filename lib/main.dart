import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:islamic_verse/controllers/Sevices/BackgroundService.dart';
import 'package:islamic_verse/views/Home/Homescreen.dart';
import 'package:islamic_verse/views/Qibla%20Finder/qiblaScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData.dark(),
      getPages: [
        GetPage(name: "/", page: () =>const HomeScreen()),
        GetPage(name: "/QiblaScreen", page: () =>const QiblaScreen()),
      ],
      initialRoute: "/",
    );
  }
}
