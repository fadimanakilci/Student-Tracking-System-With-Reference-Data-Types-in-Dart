import 'package:flutter/material.dart';
import 'package:my_app/models/student.dart';
import 'package:my_app/validation/student_validator.dart';

class EditStudent extends StatefulWidget{
  Student selectedStudent;

  EditStudent(Student selectedStudent){
    this.selectedStudent = selectedStudent;
  }

  @override
  State<StatefulWidget> createState() {
    return _EditStudentState(selectedStudent);
  }

}
// Bir class sadece bir kere inherit edilebilir. Eğer farklı classın fonksiyonlarını
// kullanacaksak with ile bildirmeliyiz. Classı inherit etmez fakat fonksiyonlarını kullanabilir.
// with den sonraki kısma mixin denir
class _EditStudentState extends State<EditStudent> with StudentValidatorMixin{
  Student selectedStudent;
  var formKey = GlobalKey<FormState>();

  _EditStudentState(Student selectedStudent) {
    this.selectedStudent = selectedStudent;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Güncellenecek Öğrenci Kaydı"),
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
      initialValue: selectedStudent.firstName,
      decoration: InputDecoration(icon: Icon(Icons.account_circle), labelText: "Öğrenci Adı", hintText: "Abcdef"),
      validator: validateFirstName,
      // Burada girilen datayı student nesnesine bağlamak için onSaved ı kullanırız
      // Kaydet butonunu basınca formdaki onSaved leri tetikleyeceğiz.
      onSaved: (String value){
        selectedStudent.firstName = value;
      },
    );
  }

  Widget buildLastNameField() {
    return TextFormField(
      initialValue: selectedStudent.lastName,
      decoration: InputDecoration(icon: Icon(Icons.account_circle), labelText: "Öğrenci Soyadı", hintText: "Abcdef"),
      validator: validateLastName,
      onSaved: (String value){
        selectedStudent.lastName = value;
      },
    );
  }

  Widget buildGradeField() {
    return TextFormField(
      initialValue: selectedStudent.grade.toString(),
      decoration: InputDecoration(icon: Icon(Icons.grade), labelText: "Öğrenci Notu", hintText: "123"),
      validator: validateGrade,
      onSaved: (String value){
        selectedStudent.grade = int.parse(value);
      },
    );
  }

  Widget buildProfilePhotoField() {
    return TextFormField(
      initialValue: selectedStudent.profilePhoto,
      decoration: InputDecoration(icon: Icon(Icons.panorama), labelText: "Öğrenci Fotoğraf URL'i", hintText: "https://abcd"),
      validator: validateProfilePhoto,
      onSaved: (String value){
        selectedStudent.profilePhoto = value;
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
          formKey.currentState.save();
          // Referans veri tiplerinin değerleri değişeceği için yeni alana ihtiyacımız yok
          //students.add(student);
          saveStudent();
          Navigator.pop(context);
        }
      },
    );
  }

  void saveStudent() {
    print(selectedStudent.id.toString() + "\n" + selectedStudent.firstName + " " + selectedStudent.lastName + "\n" + selectedStudent.grade.toString() + "\n" + selectedStudent.profilePhoto);
  }

}