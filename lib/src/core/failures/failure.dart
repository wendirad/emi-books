import 'package:equatable/equatable.dart';

abstract class Failure with Equatable {
  final String message;
  final String? code;

  const Failure({required this.message, this.code});

  @override
  List<Object?> get props => [message, ?code];

  @override
  String toString() {
    return message;
  }
}
