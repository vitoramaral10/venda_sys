import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'config/constants.dart';
import 'views/app.dart';

void main() async {
  log('Running in ${const String.fromEnvironment('flavor')} flavor',
      name: 'main');

  await Hive.initFlutter();
  await Hive.openBox(Constants.boxName,
      compactionStrategy: (entries, deletedEntries) {
    return deletedEntries > 10;
  });

  runApp(const App());
}
