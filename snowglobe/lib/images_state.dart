import 'package:flutter/material.dart';

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

  void select(int i) {
    print(i);
    if (i >= 0 && i < images.length) {
      _selection = i;
    } else {
      _selection = -1;
    }
    notifyListeners();
  }

  int get selection => _selection;
}
