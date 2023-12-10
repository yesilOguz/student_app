import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:student_app/models/attendance.dart';
import 'package:student_app/utilities/validators.dart';

import '../models/grade.dart';
import '../utilities/form_widgets.dart';

class UpdateStudentScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Grade grade;
  Attendance attendance;

  String nameValue = "";
  String lastNameValue = "";
  int gradeValue = 0;
  int absentValue = 0;

  int studentId = 0;

  UpdateStudentScreen(this.studentId, this.grade, this.attendance);

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
      title: const Text("Update Student"),
      centerTitle: true,
      titleTextStyle: const TextStyle(color: Colors.white54, fontSize: 24.0),
      backgroundColor: Colors.black54,
    );
  }

  buildBody(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              FormWidgets.buildFormFieldInitialValue("Name Surname", "${grade.name} ${grade.lastName}", const Icon(Icons.person), Validators.nameValidator, nameSave, false),
              const SizedBox(
                height: 10,
              ),
              FormWidgets.buildFormFieldInitialValue("Grade", "${grade.grade}", const Icon(Icons.grade_outlined), Validators.gradeValidator, gradeSave, true),
              const SizedBox(
                height: 10,
              ),
              FormWidgets.buildFormFieldInitialValue("Absent", "${attendance.absent}", const Icon(Icons.schedule_outlined), Validators.absentValidator, absentSave, true),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(onPressed: ()=>saveStudent(context), child: const Text("Submit"))
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

  void absentSave(String? value){
    absentValue = int.parse(value.toString());
  }

  void gradeSave(String? value){
    gradeValue = int.parse(value.toString());
  }

  void saveStudent(BuildContext context){
    if(_formKey.currentState!.validate()){
      _formKey.currentState!.save();
    }

    this.grade.grade = gradeValue;
    this.grade.name = nameValue;
    this.grade.lastName = lastNameValue;

    this.attendance.absent = absentValue;

    Grade grade = Grade(studentId, nameValue, lastNameValue, gradeValue);
    Attendance attendance = Attendance(studentId, absentValue);

    final docGradeRef = firestore.collection("Grades").doc("G-$studentId");
    firestore.runTransaction((transaction) async{
      transaction.update(docGradeRef, grade.toMap());
    });

    final docAttendanceRef = firestore.collection("Attendance").doc("A-$studentId");
    firestore.runTransaction((transaction) async{
      transaction.update(docAttendanceRef, attendance.toMap());
    });


    Navigator.pop(context);
  }

}
