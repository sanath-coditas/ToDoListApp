import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {}

class InsertionFailure extends Failure {
  final String message;
  InsertionFailure({required this.message});
  @override
  List<Object?> get props => [message];
}

class DeletionFailure extends Failure {
  final String message;
  DeletionFailure({required this.message});

  @override
  List<Object?> get props => [message];
}

class FetchFailure extends Failure {
  final String message;
  FetchFailure({required this.message});

  @override
  List<Object?> get props => [message];
}
class UpdationFailure extends Failure{
  final String message;
  UpdationFailure({required this.message});
  @override
  List<Object?> get props => [message];

}