import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:moi_interview/app.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('user');
  runApp(const App());
}
