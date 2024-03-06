import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snowglobe/image_detail.dart';
import 'package:snowglobe/images_state.dart';

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
                            return const ImageDetail();
                          },
                          settings:
                              RouteSettings(arguments: index)));
                },
                child: ListTile(title: Text(value.images[index].name)));
          },
        );
      });
}
