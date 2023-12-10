import 'package:cloud_firestore/cloud_firestore.dart';

class MessagesFromTeacher{
  int id;
  String teacherPhoto; //url
  String teacherName;
  String teacherLastName;
  String message;
  late DocumentReference reference;

  MessagesFromTeacher.withRef(this.id, this.teacherPhoto, this.teacherName, this.teacherLastName, this.message, this.reference);
  MessagesFromTeacher(this.id, this.teacherPhoto, this.teacherName, this.teacherLastName, this.message);

  Map<String, dynamic> toMap(){
    return {"id": id, "teacherName": teacherName, "teacherLastName": teacherLastName, "teacherPhoto": teacherPhoto, "message":message};
  }
}