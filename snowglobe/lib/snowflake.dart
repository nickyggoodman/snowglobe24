import 'package:flutter/material.dart';

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

  const Snowflake({super.key, required this.x, required this.y});
  
  @override
  State<StatefulWidget> createState() => _SnowflakeState();
}

class _SnowflakeState extends State<Snowflake> {
  @override
  Widget build(BuildContext context) {
    return const SmallCircle(diameter: 10.0);
  }

}