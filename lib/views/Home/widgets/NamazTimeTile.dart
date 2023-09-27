import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
class NamazTimeTile extends StatelessWidget {
  final String namazTime;
  final double animationTime;
  const NamazTimeTile({
    required this.namazTime,
    required this.animationTime,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
        from: animationTime,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: ListTile(
            title: Text(
              namazTime.toUpperCase(),
              style:const TextStyle(fontWeight: FontWeight.bold,fontSize: 17),
            ),
            trailing: Text("7:23", style:const TextStyle(fontWeight: FontWeight.bold,fontSize: 17)),
          ),
        ));
  }
}
