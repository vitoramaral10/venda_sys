import 'dart:developer';

import 'package:flutter/material.dart';

import 'views/app.dart';

void main() async {
  log('Running in ${const String.fromEnvironment('flavor')} flavor',
      name: 'main');

  runApp(const App());
}
