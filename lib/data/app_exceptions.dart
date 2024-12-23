class AppExceptions implements Exception{
  String? message;
  String? prefix;

  AppExceptions({this.message,this.prefix});

  String toString(){
    return "$message,$prefix";
  }
}

class CommunicationException extends AppExceptions{
  String? message;
  CommunicationException({this.message}) : super(prefix: "No Internet");
}
class AuthException extends AppExceptions{
  String? message;
  AuthException({this.message}) : super(prefix: "Unauthorized User");
}
class BadException extends AppExceptions{
  String? message;
  BadException({this.message}) : super(prefix: "Invalid Request");
}
class InvalidInputException extends AppExceptions{
  String? message;
  InvalidInputException({this.message}) : super(prefix: "Invalid Input");
}
