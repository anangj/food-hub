import 'package:dartz/dartz.dart';
import 'package:tut_app/data/network/failure.dart';
import 'package:tut_app/data/request/request.dart';
import 'package:tut_app/domain/model/model.dart';

abstract class Repository {
  //either for possible response
  Future<Either<Failure, Authentication>> login(LoginRequest loginRequest);
}
