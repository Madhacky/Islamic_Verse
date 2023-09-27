import 'package:get/get.dart';

class NamazTimeController extends GetxController{
    String printDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    update();
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds ";
  }
}