import 'package:flutter/material.dart';
import 'package:my_app/screens/edit_student.dart';
import 'package:my_app/screens/new_student.dart';

import 'models/student.dart';

void main() {
  runApp(MyApp());
}
// Stateless widget ekranda sadece bir kez çizilir. Eğer biz işlemlerimizi burada
// yaparsak değişkenlere verdiğimiz ilk değer ekrana yazdırılır fakat sonradan
// değeri değişen değişkenin yeni değerini ekrana yazdırmaz. Bu yüzden burada
// daha çok tema gibi bir kez çizilip sonrasında hep sabit kalacak işlemler yapılır.
// Diğer işlemler için ise stateful widget kullanılır.
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        backgroundColor: Colors.blueAccent,
      ),
      home: MyHomePage(title: 'Student Tracking System'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  Student selectedStudent = Student.withId(0,"","",0,"");

  List<Student> students = [
    Student.withId(1, "Fadimana", "Kilci", 55, "https://cdn.pixabay.com/photo/2015/07/31/14/35/figure-869154_960_720.jpg"),
    Student.withId(2, "Mustafa", "Kılıç", 30, "https://cdn.pixabay.com/photo/2020/08/29/16/08/pikachu-5527379_960_720.jpg"),
    Student.withId(3, "Aslı", "Yılmaz", 70, "https://cdn.pixabay.com/photo/2017/10/11/17/46/graduation-2841876_960_720.jpg")

  ];

  void _incrementCounter() {
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: buildBody(context)

    );
  }

  String calculateExamScore(int score){
    String message = "";
    if(score >= 60){
      message = "Geçti";
    }else if(score >= 40){
      message = "Bütünlemeye Kaldı";
    }else{
      message = "Kaldı";
    }
    return message;
  }

  void showMessage(BuildContext context, String message){
    var alert = AlertDialog(
      title: Text("Bildiri: "),
      content: Text(message),
    );
    showDialog(context: context, builder: (BuildContext context) => alert);
  }

  Widget buildBody(BuildContext context) {
    return Column(
      children: <Widget> [
        SizedBox(height: 20.0,),
        Expanded(
            child: ListView.builder(
                itemCount: students.length,
                itemBuilder: (BuildContext context, int index){
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                          students[index].profilePhoto),

                    ),
                    title: Text(students[index].firstName + " " + students[index].lastName),
                    subtitle: Text("Sınavdan aldığı not: " + students[index].grade.toString() + "[" + students[index].getStatus + "]"),
                    trailing: buildStatusIcon(students[index].grade),
                    onTap: (){
                      setState(() {
                        selectedStudent = students[index];
                      });
                      print(selectedStudent.firstName);
                    },
                  );
                }
            )
        ),
        Text("Seçili Öğrenci: " + selectedStudent.firstName + " " + selectedStudent.lastName),
        SizedBox(height: 10.0),
        Row(
          children: <Widget>[
            Flexible(
              fit: FlexFit.tight,
                flex: 3,
                child: RaisedButton(
                  color: Colors.greenAccent,
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.add),
                      SizedBox(width: 3.0),
                      Text("Yeni Öğrenci", style: TextStyle(fontSize: 12.0))
                    ],
                  ),
                  onPressed: (){
                    //var mes = "Yeni öğrenci kaydı eklemek için ilgili sayfaya yönlendiriliyorsunuz.";
                    //showMessage(context, mes.toString());
                    // Students referans veri olduğu için verinin kendisi değil bellek adresi gönderilir.
                    Navigator.push(context, MaterialPageRoute(builder: (context) => NewStudent(students)));
                  },
                )
            ),
            Flexible(
              fit: FlexFit.tight,
                flex: 3,
                child: RaisedButton(
                  color: Colors.amberAccent,
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.update),
                      SizedBox(width: 3.0),
                      Text("Güncelle", style: TextStyle(fontSize: 12.0))
                    ],
                  ),
                  onPressed: (){
                    //var mes = calculateExamScore(35);
                    //showMessage(context, mes);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => EditStudent(selectedStudent)));
                  },
                )
            ),
            Flexible(
                fit: FlexFit.tight,
                flex: 2,
                child: RaisedButton(
                  color: Colors.deepOrangeAccent,
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.delete),
                      SizedBox(width: 3.0),
                      Text("Sil", style: TextStyle(fontSize: 12.0))
                    ],
                  ),
                  onPressed: (){
                    setState(() {
                      students.remove(selectedStudent);
                    });
                    var mes = selectedStudent.firstName + " " + selectedStudent.lastName + " isimli öğrencinin kaydı silindi.";
                    showMessage(context, mes);

                  },
                )
            )
          ],
        ),
        SizedBox(height: 20.0)
      ],
    );
  }

  Widget buildStatusIcon(int grade) {
    if(grade >= 60){
      return Icon(Icons.done);
    }else if(grade >= 40){
      return Icon(Icons.watch_later_outlined);
    }else{
      return Icon(Icons.remove);
    }
  }
  
}
