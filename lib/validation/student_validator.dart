class StudentValidatorMixin{
  String validateFirstName(String value){
    if(value.length < 2)
      return "Girilen öğrenci adı 2 karakterden fazla olmalıdır.";
    else if(value.length > 25)
      return "Girilen öğrenci adı en fazla 25 karakter olmalıdır.";
  }
  String validateLastName(String value){
    if(value.length < 2)
      return "Girilen öğrenci soyadı 2 karakterden fazla olmalıdır.";
    else if(value.length > 20)
      return "Girilen öğrenci soyadı en fazla 20 karakter olmalıdır.";
  }
  String validateGrade(String value){
    int grade = int.parse(value);
    if(grade < 0 || grade > 100)
      return "Girilen öğrenci notu 0 ile 100 aralığında tam sayı olmalıdır.";
  }
  String validateProfilePhoto(String value){
    if(value.startsWith('https://', 1))
      return "Lütfen URL'i giriniz.";
  }
}