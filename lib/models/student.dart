import 'package:flutter/cupertino.dart';

class Student {
  int id;
  String firstName;
  String lastName;
  int grade;
  String profilePhoto;
  String _status;

  // Constructor
  Student(String firstName, String lastName, int grade){
    this.firstName = firstName;
    this.lastName = lastName;
    this.grade = grade;
    this.profilePhoto = profilePhoto;
  }

  // Constructor
  Student.withId(int id, String firstName, String lastName, int grade, String profilePhoto) {
    this.id = id;
    this.firstName = firstName;
    this.lastName = lastName;
    this.grade = grade;
    this.profilePhoto = profilePhoto;
  }

  // Students a öğrenci bilgisi atamadan yeni bir öğrenci oluşturmak demek
  // Constructor
  Student.withoutInfo(){

  }

  String get getStatus{
    String message = "";
    if(this.grade >= 60){
      message = "Geçti";
    }else if(this.grade >= 40){
      message = "Bütünlemeye Kaldı";
    }else{
      message = "Kaldı";
    }
    return message;
  }
}
