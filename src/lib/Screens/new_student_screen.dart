import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:student_app/models/attendance.dart';
import 'package:student_app/utilities/validators.dart';

import '../models/grade.dart';
import '../utilities/form_widgets.dart';

class NewStudentScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  String nameValue = "";
  String lastNameValue = "";
  int gradeValue = 0;

  int studentCount = 0;

  NewStudentScreen(this.studentCount);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      backgroundColor: Colors.white24,
      body: buildBody(context),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Text("New Student"),
      centerTitle: true,
      titleTextStyle: TextStyle(color: Colors.white54, fontSize: 24.0),
      backgroundColor: Colors.black54,
    );
  }

  buildBody(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(15),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              FormWidgets.buildFormField("Name Surname", "John Wick", Icon(Icons.person), Validators.nameValidator, nameSave, false),
              SizedBox(
                height: 10,
              ),
              FormWidgets.buildFormField("Grade", "100", Icon(Icons.grade_outlined), Validators.gradeValidator, gradeSave, true),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(onPressed: ()=>saveStudent(context), child: Text("Submit"))
            ],
          ),
        ));
  }

  void nameSave(String? value){
    List<String> nameSurname = value!.toString().trim().split(" ");

    lastNameValue = nameSurname.last;

    nameSurname.removeLast();

    nameValue = nameSurname.join(" ");

  }

  void gradeSave(String? value){
    gradeValue = int.parse(value.toString());
  }

  void saveStudent(BuildContext context){
    if(_formKey.currentState!.validate()){
      _formKey.currentState!.save();
    }

    Grade grade = Grade(studentCount+1, nameValue, lastNameValue, gradeValue);
    Attendance attendance = Attendance(studentCount+1, 0);
    
    final docGradeRef = firestore.collection("Grades").doc("G-${studentCount+1}");
    firestore.runTransaction((transaction) => docGradeRef.set(grade.toMap()));

    final docAttendanceRef = firestore.collection("Attendance").doc("A-${studentCount+1}");
    firestore.runTransaction((transaction) => docAttendanceRef.set(attendance.toMap()));

    Navigator.pop(context);

  }

}
