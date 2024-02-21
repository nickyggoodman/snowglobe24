import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snowglobe/images_state.dart';

class ImageDetail extends StatelessWidget {
  const ImageDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final int idx = ModalRoute.of(context)?.settings.arguments as int;
    ImageData idata = Provider.of<ImagesState>(context).images[idx];
    final String name = idata.name;
    return Scaffold(
      appBar: AppBar(title: Text(name)),
      body: LayoutBuilder(
          builder: (context, constraints) => OrientationBuilder(
              builder: (context, orientation) => Flex(
                      direction: orientation == Orientation.portrait
                          ? Axis.vertical
                          : Axis.horizontal,
                      children: [
                        SizedBox(
                            width: constraints.biggest.shortestSide,
                            child: Image.asset(idata.location)),
                        MaterialButton(
                          child: const Text('Select Image'),
                          onPressed: () {
                            Provider.of<ImagesState>(context).select(idx);
                          },
                        )
                      ]))),
    );
  }
}
