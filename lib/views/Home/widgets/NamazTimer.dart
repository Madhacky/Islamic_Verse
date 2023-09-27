import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:islamic_verse/controllers/NamazTimeController.dart';

class NamazTimer extends StatefulWidget {
  const NamazTimer({super.key});

  @override
  State<NamazTimer> createState() => _NamazTimerState();
}

class _NamazTimerState extends State<NamazTimer> { 
    var format = DateFormat("hh:mm");

  NamazTimeController namazTimeController=Get.put(NamazTimeController());
   
  @override
  Widget build(BuildContext context) {
      var one = format.parse(format.format(DateTime.now()));
    var two = format.parse("9:25");
    return  Center(
        child: CircularCountDownTimer(
          duration: two.difference(one).inSeconds,
          initialDuration: 0,
          controller: CountDownController(),
          width: Get.width / 2,
          height: Get.height / 2,
          ringColor: Colors.grey[300]!,
          ringGradient: null,
          fillColor: Colors.purpleAccent[100]!,
          fillGradient: null,
          backgroundColor: Colors.purple[500],
          backgroundGradient: null,
          strokeWidth: 20.0,
          strokeCap: StrokeCap.round,
          textStyle: const TextStyle(
              fontSize: 33.0, color: Colors.white, fontWeight: FontWeight.bold),
          textFormat: CountdownTextFormat.S,
          isReverse: true,
          isReverseAnimation: true,
          isTimerTextShown: true,
          autoStart: true,
          onStart: () {
            debugPrint('Countdown Started');
          },
          onComplete: () {
            debugPrint('Countdown Ended');

            // timeToSeconds.updateNextTime(sampleTime.values.elementAt(i+1));
          },
          onChange: (String timeStamp) {
            debugPrint('Countdown Changed $timeStamp');
          },
          timeFormatterFunction: (defaultFormatterFunction, duration) {
            if (duration.inSeconds == 0) {
              return "Start";
            } else {
              return 
              
               namazTimeController.printDuration(duration);

              //  Function.apply(defaultFormatterFunction, [duration]);
            }
          },
        ),
      );
  }
}