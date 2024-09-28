import 'package:flutter/material.dart';

class ChartDataModel {
  ChartDataModel(this.x, this.y, [this.color]);
  final String x;
  final double y;
  final Color? color;
}