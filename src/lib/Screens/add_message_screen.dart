import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:student_app/models/messages_from_teacher.dart';
import 'package:student_app/utilities/form_widgets.dart';
import 'package:student_app/utilities/validators.dart';

class AddMessageScreen extends StatelessWidget{
  final _formKey = GlobalKey<FormState>();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  int studentId;
  List<MessagesFromTeacher> messages;

  String teacherName = "";
  String teacherLastName = "";
  String teacherPhoto = "";
  String message = "";

  AddMessageScreen(this.studentId, this.messages);

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
      title: const Text("Add Message"),
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
                FormWidgets.buildFormField("Teacher name", "Adam Smith", const Icon(Icons.person), Validators.nameValidator, saveTeacherName, false),
                const SizedBox(height: 10,),
                FormWidgets.buildFormField("Teacher photo url", "https://images.pexels.com/photos/935943/pexels-photo-935943.jpeg",
                    const Icon(Icons.image_rounded), Validators.basicValidator, savePhotoUrl, false, length: 120),
                const SizedBox(height: 10,),
                FormWidgets.buildFormField("Message", "You are the best!!", const Icon(Icons.message), Validators.basicValidator, saveMessage, false, length: 120),
                const SizedBox(height: 10,),
                ElevatedButton(onPressed: ()=>saveData(context), child: const Text("Submit"))
              ],
            ),
        ),
    );
  }

  void saveTeacherName(String? value) {
    final teacherNameSurname = value!.toString().trim().split(" ");

    teacherLastName = teacherNameSurname.last;

    teacherNameSurname.removeLast();

    teacherName = teacherNameSurname.join(" ");

  }

  void savePhotoUrl(String? value) {
    teacherPhoto = value!.toString().trim();
  }

  void saveMessage(String? value) {
    message = value!.toString().trim();
  }

  saveData(BuildContext context){
    if(_formKey.currentState!.validate()){
      _formKey.currentState!.save();
    } else {
      return;
    }

    final docRef = firestore.collection("MessagesFromTeacher").doc("M-${studentId}-${messages.length+1}");
    MessagesFromTeacher teacherMessage = MessagesFromTeacher(studentId, teacherPhoto, teacherName, teacherLastName, message);

    messages.add(teacherMessage);

    firestore.runTransaction((transaction) async{
      await transaction.set(docRef, teacherMessage.toMap());
    });

    Navigator.pop(context);
  }
}