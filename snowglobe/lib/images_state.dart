import 'dart:async';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum ImageDataSource { url, asset, file }

class ImageData {
  final String name;
  final String location;
  final ImageDataSource type;

  ImageData({required this.name, required this.location, required this.type});
}

class ImagesState extends ChangeNotifier {
  final List<ImageData> images = [
    ImageData(
        name: 'Washington Monument',
        location: "images/wmon.jpg",
        type: ImageDataSource.asset),
    ImageData(
        name: 'Independence Hall',
        location: "images/indhall.jpg",
        type: ImageDataSource.asset),
    ImageData(
        name: 'Brendan Iribe Center',
        location: "images/iribe.jpg",
        type: ImageDataSource.asset),
    ImageData(
        name: 'Taj Mahal',
        location: "images/tajmahal.jpg",
        type: ImageDataSource.asset)
  ];

  int _selection = -1;

  int _numFlakes = 100;
  double _flakeSize = 5.0;
  double _xMinKick = -50.0;
  double _xMaxKick = 50.0;
  double _yMinKick = 50.0;
  double _yMaxKick = 100.0;

  final AudioPlayer _player = AudioPlayer();
  final AssetSource _sound = AssetSource('sounds/shake.mp3');
  late StreamSubscription<UserAccelerometerEvent> _sub;

  ImagesState() {
    _setState();
    _sub = userAccelerometerEventStream().listen((event) {
      final acc =
          sqrt(event.x * event.x + event.y * event.y + event.z * event.z);
      if (acc > 1.0) {
        final vol = acc >= 10.0 ? 1.0 : sqrt(acc / 10.0);
        _player.play(_sound, volume: vol);
      }
    });
  }

  @override
  void dispose() {
    _sub.cancel();
    super.dispose();
  }

  Future<void> _setState() async {
    final prefs = await SharedPreferences.getInstance();
    _numFlakes = prefs.getInt('numFlakes') ?? 100;
    _flakeSize = prefs.getDouble('flakeSize') ?? 5.0;
    _xMinKick = prefs.getDouble('xmin') ?? -50.0;
    _xMaxKick = prefs.getDouble('xmax') ?? 50.0;
  }

  int get numFlakes => _numFlakes;
  double get flakeSize => _flakeSize;
  double get xMinKick => _xMinKick;
  double get xMaxKick => _xMaxKick;
  double get yMinKick => _yMinKick;
  double get yMaxKick => _yMaxKick;

  void setNumFlakes(int n) {
    _numFlakes = n;
    SharedPreferences.getInstance().then(
      (value) {
        value.setInt('numFlakes', n);
      },
    );
    notifyListeners();
  }

  void setFlakeSize(double s) {
    _flakeSize = s;
    notifyListeners();
  }

  void setXMinKick(double v) {
    _xMinKick = v;
    notifyListeners();
  }

  void setXMaxKick(double v) {
    _xMaxKick = v;
    notifyListeners();
  }

  void setYMinKick(double v) {
    _yMinKick = v;
    notifyListeners();
  }

  void setYMaxKick(double v) {
    _yMaxKick = v;
    notifyListeners();
  }

  void select(int i) {
    if (i >= 0 && i < images.length) {
      _selection = i;
    } else {
      _selection = -1;
    }
    notifyListeners();
  }

  int get selection => _selection;
}
