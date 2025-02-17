import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:provider/provider.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:snowglobe/images_state.dart';

class Shaker extends ChangeNotifier {
  void shake() {
    notifyListeners();
  }
}

class SmallCircle extends StatelessWidget {
  const SmallCircle({super.key, required this.diameter});

  final double diameter;

  @override
  Widget build(BuildContext context) {
    return Align(
        child: Container(
      width: diameter,
      height: diameter,
      decoration: const ShapeDecoration(
          shape: CircleBorder(side: BorderSide.none), color: Colors.white),
    ));
  }
}

class Snowflake extends StatefulWidget {
  final double x;
  final double y;
  final double width;
  final double height;
  final double drag;
  final double time;
  final double velocity;

  const Snowflake(
      {super.key,
      required this.x,
      required this.y,
      required this.width,
      required this.height,
      required this.drag,
      required this.time,
      required this.velocity});

  @override
  State<StatefulWidget> createState() => _SnowflakeState();
}

class _SnowflakeState extends State<Snowflake> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Simulation _ysimulation;
  late Simulation _xsimulation;
  late double _a;

  void kick(
      {required double minDx,
      required double maxDx,
      required double minDy,
      required double maxDy}) {
    final Random r = Random();
    final double dx = minDx + (maxDx - minDx) * r.nextDouble();
    final double dy = minDy + (maxDy - minDy) * r.nextDouble();
    final double t = _controller.value;
    final double x = _xsimulation.x(t);
    final double y = _ysimulation.x(t);
    final double d = max(widget.height - y, 0);
    final double tFinal = -dy / _a + sqrt(dy * dy / (_a * _a) + 2.0 * d / _a);
    _ysimulation = GravitySimulation(_a, y, widget.height, dy);
    _xsimulation = FrictionSimulation(widget.drag, x, dx);
    _controller.value = 0;
    _controller.animateTo(tFinal, duration: Duration(seconds: tFinal.round()));
  }

  @override
  void initState() {
    super.initState();
    _a = 2 * widget.height / (widget.time * widget.time);
    _controller = AnimationController(vsync: this, upperBound: widget.height);
    _ysimulation = GravitySimulation(_a, widget.y, widget.height, 0);
    _xsimulation = FrictionSimulation(widget.drag, widget.x, widget.velocity);
    _controller.value = 0;
    _controller.animateTo(widget.time,
        duration: Duration(seconds: widget.time.round()));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final iState = Provider.of<ImagesState>(context, listen: true);
    Provider.of<Shaker>(context, listen: true).addListener(
      () {
        kick(
            minDx: iState.xMinKick,
            maxDx: iState.xMaxKick,
            minDy: -iState.yMaxKick,
            maxDy: -iState.yMinKick);
      },
    );
    return StreamBuilder<UserAccelerometerEvent>(
        stream: userAccelerometerEventStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data;
            double dx = data?.x ?? 0.0;
            double dy = data?.y ?? 0.0;
            if (dy > 0) dy *= -1;
            if (dx * dx + dy * dy > 4) {
              kick(
                  minDx: (dx - 1) * 5,
                  maxDx: (dx + 1) * 5,
                  minDy: (dy - 5) * 5,
                  maxDy: (dy - 6)* 5);
            }
          }
          return AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                final t = _controller.value;
                return Stack(
                  children: [
                    Positioned(
                        width: widget.width,
                        height: widget.height,
                        left: _xsimulation.x(t),
                        top: _ysimulation.x(t),
                        child: SmallCircle(
                          diameter:
                              Provider.of<ImagesState>(context, listen: true)
                                  .flakeSize,
                        ))
                  ],
                );
              });
        });
  }
}
