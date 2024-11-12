
import 'package:flutter/material.dart';

const List<Color> _colorThemes = [
  Colors.cyan,
  Colors.green
];

class AppTheme {
  Color? selectedColor;

  AppTheme({
    this.selectedColor
  });

  ThemeData theme () {
    return ThemeData(
      useMaterial3: true,
      colorSchemeSeed: this.selectedColor
    );
  }
}