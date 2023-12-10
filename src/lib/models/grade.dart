import 'package:cloud_firestore/cloud_firestore.dart';

class Grade{
  int id;
  String name;
  String lastName;
  int grade;
  late DocumentReference reference;

  Grade.withRef(this.id, this.name, this.lastName, this.grade, this.reference);
  Grade(this.id, this.name, this.lastName, this.grade);

  Map<String, dynamic> toMap(){
    return {"id": id, "name": name, "lastName": lastName, "grade": grade};
  }

}