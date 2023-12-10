import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:student_app/Screens/student_datas_screen.dart';
import 'package:student_app/Screens/student_grades_screen.dart';

import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MaterialApp(
    initialRoute: "/",
    routes: {
      "/": (context) => StudentGradesScreen(),
    },
  ));
}
