import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'task.dart';

class CompletionMeter extends StatefulWidget {
  final Task task;
  final double radius;

  CompletionMeter({Key key, @required this.task, @required this.radius}) : super(key: key);

  @override
  _CompletionMeterState createState() => _CompletionMeterState();
}

class _CompletionMeterState extends State<CompletionMeter> {

  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      radius: widget.radius,
      lineWidth: 10.0,
      percent: widget.task.taskProgress,
      animateFromLastPercent: true,
      animation: true,
      progressColor: widget.task.color,
      backgroundColor: Colors.transparent,
      arcType: ArcType.FULL,
      circularStrokeCap: CircularStrokeCap.round,
      center: CircularPercentIndicator(
        radius: widget.radius,
        lineWidth: 10.0,
        percent: 1.0,
        progressColor: Colors.white10,
        backgroundColor: Colors.transparent,
        arcType: ArcType.FULL,
        circularStrokeCap: CircularStrokeCap.round,
        center: Text(
          (widget.task.taskProgress*100).toStringAsFixed(2) + ' %',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        ),
    );
  }
}