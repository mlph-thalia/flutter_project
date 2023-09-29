import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ebus/presentation/app/view/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const App());
}