import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snowglobe/counter_tab.dart';
import 'package:snowglobe/image_list.dart';
import 'package:snowglobe/images_state.dart';
import 'package:snowglobe/snowglobe.dart';

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
      home: const SnowglobeHomepage(),
    );
  }
}

class SnowglobeHomepage extends StatelessWidget {
  const SnowglobeHomepage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            appBar: AppBar(
              title: const Text('Snowglobe'),
              bottom: const TabBar(
                tabs: [Tab(text: 'Images'), Tab(text: 'Globe'), Tab(text: 'Counter')],
              ),
            ),
            body: const TabBarView(
              children: [ImageList(), Snowglobe(), CounterTab()],
            )));
  }
}
