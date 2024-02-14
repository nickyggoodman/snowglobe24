import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
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

class ImageDetail extends StatelessWidget {
  const ImageDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final String name = ModalRoute.of(context)?.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(title: Text(name)),
      body: LayoutBuilder(
          builder: (context, constraints) => OrientationBuilder(
              builder: (context, orientation) => Flex(
                      direction: orientation == Orientation.portrait
                          ? Axis.vertical
                          : Axis.horizontal,
                      children: [
                        Icon(
                          Icons.ac_unit,
                          size: constraints.biggest.shortestSide,
                        ),
                        MaterialButton(
                          child: const Text('Select Image'),
                          onPressed: () {
                            print('hello');
                          },
                        )
                      ]))),
    );
  }
}

class ImageList extends StatelessWidget {
  final List<String> images = [
    'Washington Monument',
    'Independence Hall',
    'Brendan Iribe Center',
    'Taj Mahal',
  ];

  ImageList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: images.length,
      itemBuilder: (context, index) {
        return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) {
                        return ImageDetail();
                      },
                      settings: RouteSettings(arguments: images[index])));
            },
            child: ListTile(title: Text(images[index])));
      },
    );
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
                      Icon(Icons.circle,
                          size: constraints.biggest.shortestSide),
                          MaterialButton(
                            child: Text('Shake'),
                            onPressed: () {
                            print('shaking');
                          },)
                    ])));
  }
}
