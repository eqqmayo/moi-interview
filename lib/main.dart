import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:moi_interview/app.dart';
import 'package:moi_interview/config/di.dart';
import 'package:moi_interview/config/hive.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  diSetup();
  hiveSetup();
  runApp(const App());
}
