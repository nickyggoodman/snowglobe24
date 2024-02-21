import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snowglobe/images_state.dart';
import 'package:snowglobe/main.dart';

class ImageList extends StatelessWidget {
  const ImageList({super.key});

  @override
  Widget build(BuildContext context) =>
      Consumer<ImagesState>(builder: (context, value, child) {
        return ListView.builder(
          itemCount: value.images.length,
          itemBuilder: (context, index) {
            return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) {
                            return ImageDetail();
                          },
                          settings:
                              RouteSettings(arguments: value.images[index])));
                },
                child: ListTile(title: Text(value.images[index].name)));
          },
        );
      });
}
