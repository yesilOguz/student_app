import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:student_app/Screens/add_message_screen.dart';
import 'package:student_app/Screens/update_student_screen.dart';
import 'package:student_app/models/attendance.dart';
import 'package:student_app/models/messages_from_teacher.dart';

import '../models/grade.dart';

class StudentDatasScreen extends StatelessWidget {
  Grade grade;
  Attendance attendance;
  List<MessagesFromTeacher> messagesFromTeacher;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  StudentDatasScreen(this.grade, this.attendance, this.messagesFromTeacher);

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
      title: StreamBuilder(stream: firestore.collection("Grades").where("id", isEqualTo: grade.id).snapshots(),
          builder: (context, snapshot) {
            if(!snapshot.hasData) return const Text("Null");
            if(snapshot.connectionState == ConnectionState.waiting) return const Text("Loading..");
            QueryDocumentSnapshot<Map<String, dynamic>> student = snapshot.data!.docs[0];
            return Text("${student["name"]} ${student["lastName"]}");
      }),
      centerTitle: true,
      titleTextStyle: TextStyle(color: Colors.white54, fontSize: 24.0),
      backgroundColor: Colors.black54,
    );
  }

  buildBody(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Student: ", style: getStyle()),
            SizedBox(
              width: 5,
            ),
            StreamBuilder(stream: firestore.collection("Grades").where("id", isEqualTo: grade.id).snapshots(),
              builder: (context, snapshot) {
                if(!snapshot.hasData) return const Text("Null");
                if(snapshot.connectionState == ConnectionState.waiting) return const Text("Loading..");
                QueryDocumentSnapshot<Map<String, dynamic>> student = snapshot.data!.docs[0];
                return Text("${student["name"]} ${student["lastName"]}", style: getStyle(),);
            }),
          ],
        ),
        SizedBox(height: 55),
        Row(
          children: [
            StreamBuilder(stream: firestore.collection("Grades").where("id", isEqualTo: grade.id).snapshots(),
                builder: (context, snapshot) {
                  if(!snapshot.hasData) return const Text("Null");
                  if(snapshot.connectionState == ConnectionState.waiting) return const Text("Loading..");
                  int studentGrade = int.parse(snapshot.data!.docs[0]["grade"].toString());
                  return Expanded(
                    child: ListTile(
                      title: Text(
                        "Grade",
                        style: getStyle(),
                      ),
                      subtitle: Text(
                        studentGrade.toString(),
                        style: getStyle(),
                      ),
                      trailing: Icon(getPerfectIconForGrade(studentGrade),
                          color: Colors.white60, size: 30),
                    ),
                  );
                },
            ),

            StreamBuilder(stream: firestore.collection("Attendance").where("id", isEqualTo: grade.id).snapshots(),
              builder: (context, snapshot) {
                if(!snapshot.hasData) return const Text("Null");
                if(snapshot.connectionState == ConnectionState.waiting) return const Text("Loading..");
                return Expanded(
                    child: ListTile(
                      title: Text("Absent", style: getStyle()),
                      subtitle: Text(
                        snapshot.data!.docs[0]["absent"].toString(),
                        style: getStyle(),
                      ),
                      trailing: Icon(getPerfectIconForAbsent(snapshot.data!.docs[0]["absent"]),
                          color: Colors.white60, size: 30),
                    ));
              },),

          ],
        ),
        buildTeacherMessages(),
        buildButtons(context),
      ],
    );
  }

  IconData? getPerfectIconForGrade(int grade) {
    if (grade > 70) {
      return Icons.sentiment_very_satisfied_rounded;
    } else if (grade > 50) {
      return Icons.sentiment_satisfied_rounded;
    } else if (grade > 30) {
      return Icons.sentiment_neutral;
    } else {
      return Icons.sentiment_dissatisfied_rounded;
    }
  }

  IconData? getPerfectIconForAbsent(int absent) {
    if (absent < 2) {
      return Icons.sentiment_very_satisfied_rounded;
    } else if (absent < 5) {
      return Icons.sentiment_satisfied_rounded;
    } else if (absent < 10) {
      return Icons.sentiment_neutral;
    } else {
      return Icons.sentiment_dissatisfied_rounded;
    }
  }

  TextStyle getStyle() {
    return TextStyle(fontSize: 22, color: Colors.white60);
  }

  Widget buildTeacherMessages() {
    return StreamBuilder(stream: firestore.collection("MessagesFromTeacher").where("id", isEqualTo: grade.id).snapshots(),
        builder: (context, snapshot) {
          if(!snapshot.hasData) return ListView.builder(itemCount: 0, itemBuilder: (context, index) => Text("null"));
          if(snapshot.connectionState == ConnectionState.waiting) return const Text("Loading..");
          return Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(15),
              shrinkWrap: true,
              itemCount: snapshot.data!.size,
              itemBuilder: (BuildContext context, int index) {
                QueryDocumentSnapshot<Map<String, dynamic>> mapMessage = snapshot.data!.docs[index];
                MessagesFromTeacher message = MessagesFromTeacher(int.parse(mapMessage["id"].toString()),
                    mapMessage["teacherPhoto"], mapMessage["teacherName"],
                    mapMessage["teacherLastName"], mapMessage["message"]);

                return Row(
                children: [
                  CircleAvatar(
                  backgroundImage: NetworkImage(message.teacherPhoto),
                  ),
                  buildMessage(message),
                  ],
                );
                },
          ));
        },);
  }

  buildMessage(MessagesFromTeacher message) {
    return Expanded(
            child: ListTile(
              title: Text("${message.teacherName} ${message.teacherLastName}"),
              subtitle: Text(message.message),
              textColor: Colors.white60,
            )
        );
  }

  Row buildButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
            onPressed: () => updateStudent(context),
            style: const ButtonStyle(
                backgroundColor:
                    MaterialStatePropertyAll<Color>(Colors.black26)),
            child: const Text("Update Student")),
        const SizedBox(
          width: 10,
        ),
        ElevatedButton(
            onPressed: () => deleteStudent(context),
            style: const ButtonStyle(
                backgroundColor:
                MaterialStatePropertyAll<Color>(Colors.black26)),
            child: const Text("Delete Student")),
        const SizedBox(
          width: 10,
        ),
        ElevatedButton(
            onPressed: () => addMessage(context),
            style: const ButtonStyle(
                backgroundColor:
                MaterialStatePropertyAll<Color>(Colors.black26)),
            child: const Text("Add Message")),
      ],
    );
  }

  updateStudent(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (BuildContext context)=>UpdateStudentScreen(grade.id, grade, attendance)),
    );
  }

  deleteStudent(BuildContext context) {
    firestore.runTransaction((transaction) async {
      await transaction.delete(grade.reference);
      await transaction.delete(attendance.reference);

      messagesFromTeacher.forEach((element) async{
        await transaction.delete(element.reference);
      });

    });

    Navigator.pop(context);
  }

  addMessage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (BuildContext context) => AddMessageScreen(grade.id, messagesFromTeacher)),
    );
  }
}
