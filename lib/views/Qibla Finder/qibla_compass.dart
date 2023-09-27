import 'dart:async';
import 'dart:math' show pi;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';

import 'location_error_widget.dart';
     var bear;
     double distance=0.0;
class QiblaCompass extends StatefulWidget {
  const QiblaCompass({Key? key}) : super(key: key);

  @override
  State<QiblaCompass> createState() => _QiblaCompassState();
}

class _QiblaCompassState extends State<QiblaCompass> {
  final _locationStreamController =
      StreamController<LocationStatus>.broadcast();

  get stream => _locationStreamController.stream;

  @override
  void initState() {
pos();
    _checkLocationStatus();
    super.initState();
  }

Future <void> pos()async{
   Position position=await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
     bear=   Geolocator.distanceBetween(position.latitude,position.longitude, 21.422487,39.826206);
    // print( ((bear) * (pi / 180) * -1));
    distance=(bear/1000);
}
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(8.0),
      child: StreamBuilder(
        stream: stream,
        builder: (context, AsyncSnapshot<LocationStatus> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CupertinoActivityIndicator();
          }
          if (snapshot.data!.enabled == true) {
            switch (snapshot.data!.status) {
              case LocationPermission.always:
              case LocationPermission.whileInUse:
           
                return QiblahCompassWidget();

              case LocationPermission.denied:
                return LocationErrorWidget(
                  error: "Location service permission denied",
                  callback: _checkLocationStatus,
                );
              case LocationPermission.deniedForever:
                return LocationErrorWidget(
                  error: "Location service Denied Forever !",
                  callback: _checkLocationStatus,
                );
              // case GeolocationStatus.unknown:
              //   return LocationErrorWidget(
              //     error: "Unknown Location service error",
              //     callback: _checkLocationStatus,
              //   );
              default:
                return Container();
            }
          } else {
            return LocationErrorWidget(
              error: "Please enable Location service",
              callback: _checkLocationStatus,
            );
          }
        },
      ),
    );
  }

  Future<void> _checkLocationStatus() async {
    final locationStatus = await FlutterQiblah.checkLocationStatus();
    if (locationStatus.enabled &&
        locationStatus.status == LocationPermission.denied) {
      await FlutterQiblah.requestPermissions();
      final s = await FlutterQiblah.checkLocationStatus();
      _locationStreamController.sink.add(s);
    } else {
      _locationStreamController.sink.add(locationStatus);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _locationStreamController.close();
    FlutterQiblah().dispose();
  }
}

class QiblahCompassWidget extends StatelessWidget {
  final _kaabaSvg = SvgPicture.asset('assets/4.svg');

  QiblahCompassWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
      
    var platformBrightness = Theme.of(context).brightness;
    return StreamBuilder(
      stream: FlutterQiblah.qiblahStream,
      builder: (_, AsyncSnapshot<QiblahDirection> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CupertinoActivityIndicator();
        }

        final qiblahDirection = snapshot.data!;
        var angle = ((qiblahDirection.qiblah) * (pi / 180) * -1);

        return Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Transform.rotate(
              angle: angle,
              child: SvgPicture.asset('assets/5.svg', // compass
                  color: platformBrightness == Brightness.dark
                      ? Colors.yellow
                      : Colors.orange),
            ),
            _kaabaSvg,
            SvgPicture.asset('assets/3.svg', //needle
                color: platformBrightness == Brightness.dark
                    ? Colors.greenAccent
                    : Colors.orange),
            const Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                "Align both arrow head\nDo not put device close to metal object.\nCalibrate the compass eveytime you use it.",
                textAlign: TextAlign.center,
              ),
            ),
            Positioned(
              bottom: 185,
              child:  Row(
                children: [
                  Text("Distance from you :  ",style: TextStyle(fontWeight: FontWeight.w700)),
                  Text(distance.toStringAsFixed(3),style: TextStyle(fontWeight: FontWeight.w400),),
                     Text("KM",style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),)
          ],
        );
      },
    );
  }
}
