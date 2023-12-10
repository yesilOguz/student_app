import 'package:cloud_firestore/cloud_firestore.dart';

class Attendance {
  int id;
  int absent;
  late DocumentReference reference;

  Attendance(this.id, this.absent);
  Attendance.withRef(this.id, this.absent, this.reference);

  Map<String, int> toMap() {
    return {"id": id, "absent": absent};
  }
}
