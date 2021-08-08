import 'package:flutter/material.dart';
import 'package:my_app/models/student.dart';
import 'package:my_app/validation/student_validator.dart';

class NewStudent extends StatefulWidget{
  List<Student> student;

  NewStudent(List<Student> student){
    this.student = student;
  }

  @override
  State<StatefulWidget> createState() {
    return _NewStudentState(student);
  }

}
// Bir class sadece bir kere inherit edilebilir. Eğer farklı classın fonksiyonlarını
// kullanacaksak with ile bildirmeliyiz. Classı inherit etmez fakat fonksiyonlarını kullanabilir.
// with den sonraki kısma mixin denir
class _NewStudentState extends State<NewStudent> with StudentValidatorMixin{
  List<Student> students;
  var student = Student.withoutInfo();
  var formKey = GlobalKey<FormState>();

  _NewStudentState(List<Student> students) {
    this.students = students;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Yeni Öğrenci Kaydı"),
      ),
      body: Container(
        margin: EdgeInsets.all(25.0),
        child: Form(
          key: formKey,
          child: Column(
            children: <Widget> [
              buildFirstNameField(),
              buildLastNameField(),
              buildGradeField(),
              buildProfilePhotoField(),
              buildSubmitButton(),
            ],
          ),
        ),
      )
    );
  }

  Widget buildFirstNameField() {
    return TextFormField(
      decoration: InputDecoration(icon: Icon(Icons.account_circle), labelText: "Öğrenci Adı", hintText: "Abcdef"),
      validator: validateFirstName,
      // Burada girilen datayı student nesnesine bağlamak için onSaved ı kullanırız
      // Kaydet butonunu basınca formdaki onSaved leri tetikleyeceğiz.
      onSaved: (String value){
        student.firstName = value;
      },
    );
  }

  Widget buildLastNameField() {
    return TextFormField(
      decoration: InputDecoration(icon: Icon(Icons.account_circle), labelText: "Öğrenci Soyadı", hintText: "Abcdef"),
      validator: validateLastName,
      onSaved: (String value){
        student.lastName = value;
      },
    );
  }

  Widget buildGradeField() {
    return TextFormField(
      decoration: InputDecoration(icon: Icon(Icons.grade), labelText: "Öğrenci Notu", hintText: "123"),
      validator: validateGrade,
      onSaved: (String value){
        student.grade = int.parse(value);
      },
    );
  }

  Widget buildProfilePhotoField() {
    return TextFormField(
      decoration: InputDecoration(icon: Icon(Icons.panorama), labelText: "Öğrenci Fotoğraf URL'i", hintText: "https://abcd"),
      validator: validateProfilePhoto,
      onSaved: (String value){
        student.profilePhoto = value;
      },
    );
    /*return CircleAvatar(
      backgroundImage: NetworkImage("https://cdn.pixabay.com/photo/2018/12/03/08/45/snow-3852960_960_720.jpg"),
    );*/
  }

  Widget buildSubmitButton() {
    int counter = 3;
    return RaisedButton(
      child: Text("Kaydet"),
      onPressed: (){
        // validate() fonksiyonu ilgili formun validatorlerini çalıştırır ve true
        // ya da false olacak şekilde boolen değer döndürür
        if(formKey.currentState.validate()){
          // save() fonksiyonu ilgili formun onSaved larını çalıştırır
          counter++;
          student.id = counter;
          formKey.currentState.save();
          students.add(student);
          saveStudent();
          Navigator.pop(context);
        }
      },
    );
  }

  void saveStudent() {
    print(student.id.toString() + "\n" + student.firstName + " " + student.lastName + "\n" + student.grade.toString() + "\n" + student.profilePhoto);
  }

}