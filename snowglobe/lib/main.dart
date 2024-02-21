import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snowglobe/globe_painter.dart';
import 'package:snowglobe/image_list.dart';
import 'package:snowglobe/images_state.dart';
import 'package:snowglobe/square_clipper.dart';

void main() {
  runApp(ChangeNotifierProvider<ImagesState>(
      create: (context) => ImagesState(), child: const MyApp()));
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
  const SnowglobeHomepage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            appBar: AppBar(
              title: const Text('Snowglobe'),
              bottom: const TabBar(
                tabs: [Tab(text: 'Images'), Tab(text: 'Globe')],
              ),
            ),
            body: const TabBarView(
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
                                child: SizedBox(
                                    height: constraints.biggest.shortestSide,
                                    width: constraints.biggest.shortestSide,
                                    child: ClipOval(
                                        clipper: SquareClipper(),
                                        child: Consumer<ImagesState>(
                                            builder: (context, value, child) {
                                          print(value.selection);
                                          return Image.asset(
                                            value.images[value.selection]
                                                .location,
                                          );
                                        }))),
                              )),
                      MaterialButton(
                        child: const Text('Shake'),
                        onPressed: () {
                          print('shaking');
                        },
                      )
                    ])));
  }
}
