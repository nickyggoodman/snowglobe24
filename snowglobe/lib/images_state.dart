import 'package:flutter/material.dart';
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

  late int _numFlakes;
  late double _flakeSize;
  late double _xMinKick;
  late double _xMaxKick;
  late double _yMinKick;
  late double _yMaxKick;

  ImagesState() {

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
    SharedPreferences.getInstance().then((value) {
      value.setInt('numFlakes', n);
    },);
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
