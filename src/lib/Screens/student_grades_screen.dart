import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:student_app/Screens/student_datas_screen.dart';
import 'package:student_app/models/attendance.dart';
import 'package:student_app/models/messages_from_teacher.dart';

import '../models/grade.dart';
import 'new_student_screen.dart';

class StudentGradesScreen extends StatelessWidget {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  int studentCount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      backgroundColor: Colors.white24,
      body: buildBody(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Text("Students Grades"),
      titleTextStyle: TextStyle(color: Colors.white54, fontSize: 24.0),
      backgroundColor: Colors.black54,
      centerTitle: true,
    );
  }

  Widget buildBody() {
    return StreamBuilder<QuerySnapshot>(
        stream: firestore.collection("Grades").orderBy("grade", descending: true).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) return Text("There is no data!!");
          return Padding(
              padding: EdgeInsets.only(top: 5),
              child: Column(
                children: [
                  Expanded(
                    child: ListView(
                      children: getItems(snapshot, context),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      generateButton(() => newStudent(context), Text("New Student"))
                    ],
                  )
                ],
              ));
        });
  }

  ElevatedButton generateButton(void Function()? func, Text text) {
    return ElevatedButton(
      onPressed: func,
      child: text,
      style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll<Color>(Colors.black26)),
    );
  }

  getItems(AsyncSnapshot<QuerySnapshot> snapshot, BuildContext context) {
    snapshot.data!.docs.forEach((element) {
      if(element["id"] > studentCount){
        studentCount = element["id"];
      }
    });

    return snapshot.data!.docs
        .map((doc) => Column(
              children: [
                Card(
                  child: ListTile(
                    title: Text(doc["name"]),
                    trailing: Text(doc["grade"].toString()),
                    textColor: Colors.white54,
                    onTap: () => getStudentDatasScreen(doc, context),
                  ),
                  color: Colors.black54,
                  shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(13))),
                ),
                SizedBox(
                  height: 5,
                )
              ],
            ))
        .toList();
  }

  void newStudent(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context)=> NewStudentScreen(studentCount)),
    );
  }

  getStudentDatasScreen(
      QueryDocumentSnapshot<Object?> doc, BuildContext context) async{

    Grade grade = Grade.withRef(int.parse(doc["id"].toString()), doc["name"].toString(),
        doc["lastName"].toString(), int.parse(doc["grade"].toString()), doc.reference);

    Attendance attendance = Attendance(0, 0);

    List<MessagesFromTeacher> messagesFromTeacher = List.empty(growable: true);

    firestore
        .collection("Attendance")
        .where("id", isEqualTo: grade.id)
        .snapshots()
        .listen((data) {
      attendance = Attendance.withRef(data.docs[0]["id"], data.docs[0]["absent"], data.docs[0].reference);
    });

    firestore
        .collection("MessagesFromTeacher")
        .where("id", isEqualTo: grade.id)
        .snapshots()
        .listen((data) {
        for (var doc in data.docs) {
          if (!doc.exists) {
            break;
          }

        MessagesFromTeacher message = MessagesFromTeacher.withRef(
            doc["id"],
            doc["teacherPhoto"],
            doc["teacherName"],
            doc["teacherLastName"],
            doc["message"],
        doc.reference);

        messagesFromTeacher.add(message);

        return;
      }
    }).onData((data) {
      print("selam");
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => StudentDatasScreen(grade, attendance, messagesFromTeacher),
      ));
    });


  }
}
