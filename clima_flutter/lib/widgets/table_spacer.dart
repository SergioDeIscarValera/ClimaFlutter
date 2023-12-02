import 'package:flutter/material.dart';

class TableSpacer {
  static TableRow rowSpacer(double gap, int columns) {
    return TableRow(
      children: List.generate(columns, (index) => SizedBox(height: gap)),
    );
  }
}
