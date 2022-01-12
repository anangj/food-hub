import 'package:tut_app/data/network/error_hendler.dart';

class Failure {
  int code; //200 or 400
  String message; //errror or success

  Failure(this.code, this.message);
}

class DefaultFailure extends Failure {
  DefaultFailure() : super(ResponseCode.DEFAULT, ResponseMessage.DEFAULT);
}
