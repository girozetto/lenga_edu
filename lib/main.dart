import 'package:flutter/material.dart';
import 'ui/app.dart';
import 'core/services/service_initializer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ServiceInitializer.init();
  runApp(const MyApp());
}
