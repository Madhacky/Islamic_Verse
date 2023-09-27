import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';

class BackgroundService extends GetxController {
  static const _fetchBackground = "fetchBackground";
  String currentDate = '';
  late SharedPreferences storage;
  Future<void> getdataInstance() async {
    storage = await SharedPreferences.getInstance();
  }

  void callbackDispatcher() {
    Workmanager().executeTask((task, inputData) async {
      switch (task) {
        case _fetchBackground:
          // Code to run in background

          break;
      }
      return Future.value(true);
    });
  }

  Future<void> getCurrentDate() async {
    var now =  DateTime.now();
    var formatter =  DateFormat('dd-MM-yyyy');
    currentDate = formatter.format(now);
    update();
  }

  //Namaz Time Api call

  Future namazTimeApiCall() async {
    await getCurrentDate();
    storage = await SharedPreferences.getInstance();
    var namazTimeData;
    var headers = {'Content-Type': 'application/json'};
    var response = await get(
      Uri.parse(
          'http://api.aladhan.com/v1/timings/$currentDate?latitude=17.422232&longitude=78.3818357&method=1'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      try {
        namazTimeData = json.decode(utf8.decode(response.bodyBytes));
String encodedjson=json.encode(namazTimeData["data"]["timings"]);
        storage.setString('NamazTime', encodedjson);
        // storage.setString('Dhuhr', namazTimeData["data"]["timings"]["Dhuhr"]);
        // storage.setString('Asr', namazTimeData["data"]["timings"]["Asr"]);
        // storage.setString(
        //     'Maghrib', namazTimeData["data"]["timings"]["Maghrib"]);
        // storage.setString('Isha', namazTimeData["data"]["timings"]["Isha"]);
        //  await timeToSeconds.getlatestdata(data: test.getString("data")!);
        
        print(storage.getString("NamazTime"));
      } catch (e) {
        print(e);
        namazTimeData = [];
      }
    } else {}
    update();
  }
}
