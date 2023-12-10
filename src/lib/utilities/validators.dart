import 'package:flutter/material.dart';

class Validators extends Widget{
  @override
  Element createElement() {
    // TODO: implement createElement
    throw UnimplementedError();
  }

  static String? absentValidator(String? value){

    if (int.tryParse(value!.toString()) == null) {
      return "The absent must be numerical!";
    }

    if(int.parse(value.toString()) < 0){
      return "Please enter valid grade!";
    }

    return null;
  }

  static String? nameValidator(String? value){
    if (value!.length < 3) {
      return "Name must have at least 3 characters!";
    }

    List<String> nameSurname = value.toString().trim().split(" ");

    if(nameSurname.length < 2){
      return "Please enter both name and surname!";
    }

    return null;
  }

  static String? gradeValidator(String? value){

    if (int.tryParse(value!.toString()) == null) {
      return "The student grade must be numerical!";
    }

    if(int.parse(value.toString()) > 100 || int.parse(value.toString()) < 0){
      return "Please enter valid grade!";
    }

    return null;
  }

  static String? basicValidator(String? value){
    if(value!.isEmpty || value.length < 3){
      return "Please enter valid value!";
    }

    return null;
  }

}