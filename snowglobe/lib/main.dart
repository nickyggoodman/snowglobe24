import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snowglobe/image_list.dart';
import 'package:snowglobe/images_state.dart';

void main() {
  runApp(ChangeNotifierProvider<ImagesState>(
      create: (context) => ImagesState(), child: const MyApp()));
}

class GlobePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double length = size.shortestSide;
    Path triangle = Path()
      ..moveTo(0.05 * length, 0.95 * length)
      ..lineTo(length / 2.0, length / 2.0)
      ..lineTo(0.95 * length, 0.95 * length)
      ..close();
    Path circle = Path()
      ..addOval(Rect.fromCenter(
          center: Offset(length / 2.0, length / 2.0),
          width: 0.75 * length,
          height: 0.75 * length));
    canvas.drawPath(triangle, Paint()..color = Colors.green);
    canvas.drawPath(
        circle,
        Paint()
          ..style = PaintingStyle.stroke
          ..color = Colors.black
          ..strokeWidth = 3.0);
    canvas.clipPath(circle);
    canvas.drawRect(Rect.largest, Paint()..color = Colors.blue);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SnowglobeHomepage(),
    );
  }
}

class SnowglobeHomepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            appBar: AppBar(
              title: Text('Snowglobe'),
              bottom: TabBar(
                tabs: [Tab(text: 'Images'), Tab(text: 'Globe')],
              ),
            ),
            body: TabBarView(
              children: [ImageList(), Snowglobe()],
            )));
  }
}

class Snowglobe extends StatelessWidget {
  const Snowglobe({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constraints) => OrientationBuilder(
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
                              )),
                      MaterialButton(
                        child: Text('Shake'),
                        onPressed: () {
                          print('shaking');
                        },
                      )
                    ])));
  }
}
