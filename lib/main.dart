import 'package:flutter/material.dart';
import 'package:moi_interview/app.dart';
import 'package:moi_interview/config/di.dart';
import 'package:moi_interview/config/hive.dart';
import 'package:moi_interview/ui/theme/injector.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  diSetup();
  hiveSetup();
  runApp(const App());
}
