import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class Percentage extends StatelessWidget {
  final double percent;

  Percentage(this.percent);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:EdgeInsets.symmetric(horizontal: 10.0),
      child:LinearPercentIndicator(
        
        lineHeight: 4.0,
        percent: percent,
        backgroundColor: Colors.grey,
        progressColor: Colors.purple[400],
        trailing: Text((percent * 100).toStringAsFixed(0)+'%'),
      ),
    );
  }
}