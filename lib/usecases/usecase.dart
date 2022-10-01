import 'package:dartz/dartz.dart';

import '../error/failure.dart';

abstract class Usecase<Type, Params> {
  Future<Either<Failure, dynamic>> call(Params params);
}
