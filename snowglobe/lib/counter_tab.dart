import 'package:flutter/material.dart';

class CounterTab extends StatefulWidget {
  const CounterTab({super.key});

  @override
  State<StatefulWidget> createState() => _CounterState();
}

class _CounterState extends State<CounterTab> {
  int _count = 0;
  late Stream<int> _countingStream;

  _CounterState() {
    _countingStream =
        Stream<int>.periodic(const Duration(seconds: 1), (computationCount) {
      return _count++;
    }).asBroadcastStream();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: StreamBuilder(
            stream: _countingStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(
                  '$_count',
                  style: Theme.of(context).textTheme.headlineLarge,
                );
              } else if (snapshot.hasError) {
                return Text('oops',
                    style: Theme.of(context).textTheme.headlineLarge);
              } else {
                return Text('starting...',
                    style: Theme.of(context).textTheme.headlineLarge);
              }
            }));
  }
}
