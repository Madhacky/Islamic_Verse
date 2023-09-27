import 'package:draggable_home/draggable_home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:islamic_verse/views/Home/widgets/GradientsCard.dart';
import 'dart:math'as math;

import 'package:islamic_verse/views/Home/widgets/NamazTImeTile.dart';
import 'package:islamic_verse/views/Home/widgets/NamazTimer.dart';
import 'package:islamic_verse/views/constants/constants.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return DraggableHome(
      alwaysShowLeadingAndAction: true,
      actions: [
      IconButton(onPressed: ()=>Get.toNamed("/QiblaScreen"), icon: Icon(Icons.location_on))
    ],
      expandedBody: expandedBody(),
      fullyStretchable: true,
      headerWidget: const NamazTimer(),
      title: Text(
        "IslamicVerse",
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      body: [
        GridView(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2),
          children: List.generate(
            8, // Number of cards to generate
            (index) => GradientCard(
              // onTap: () => Get.toNamed("/Namaz"),
              // You can customize the gradient colors and card content here
              gradientColors: [
                Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
                    .withOpacity(1.0),
                Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
                    .withOpacity(1.0)
                // Colors.blue,
                // Colors.purple,
              ],
              cardTitle: cardtitle[index],
              cardContent: cardContent[index],
            ),
          ),
        ),
      ],
    );
  }

  
  Widget expandedBody() {
    return const  SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          NamazTimer(),
          NamazTimeTile(animationTime:100 ,namazTime: "Fajr"),
           NamazTimeTile(animationTime:150 ,namazTime: "Dhuhr"),
            NamazTimeTile(animationTime:200 ,namazTime: "Asr"),
             NamazTimeTile(animationTime:250 ,namazTime: "Maghrib"),
              NamazTimeTile(animationTime:300 ,namazTime: "Isha"),
         
        ],
      ),
    );
  }
  
}