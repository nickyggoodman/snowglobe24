import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snowglobe/globe_painter.dart';
import 'package:snowglobe/images_state.dart';
import 'package:snowglobe/snowflake.dart';
import 'package:snowglobe/square_clipper.dart';

class Snowglobe extends StatelessWidget {
  const Snowglobe({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      List<Widget> globeItems = [];
      globeItems.add(Positioned(
        child: Consumer<ImagesState>(builder: (context, value, child) {
        print(value.selection);
        return Image.asset(
          value.images[value.selection].location,
        );
      })));
      Random r = Random();
      for (int i = 0; i < 100; i++) {
        double x = constraints.biggest.shortestSide * r.nextDouble();
        double y = constraints.biggest.shortestSide * r.nextDouble();
        globeItems
            .add(Positioned(left: x, top: y, child: Snowflake(x: x, y: y)));
      }
      return OrientationBuilder(
          builder: (context, orientation) => Flex(
                  direction: orientation == Orientation.portrait
                      ? Axis.vertical
                      : Axis.horizontal,
                  children: [
                    LayoutBuilder(
                      builder: (context, constraints) => CustomPaint(
                          painter: GlobePainter(),
                          size: Size(constraints.biggest.shortestSide,
                              constraints.biggest.shortestSide),
                          child: SizedBox(
                            height: constraints.biggest.shortestSide,
                            width: constraints.biggest.shortestSide,
                            child: ClipOval(
                                clipper: SquareClipper(),
                                child: Stack(children: globeItems)),
                          )),
                    ),
                    MaterialButton(
                      child: const Text('Shake'),
                      onPressed: () {
                        print('shaking');
                      },
                    )
                  ]));
    });
  }
}
