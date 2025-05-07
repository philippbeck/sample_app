// ignore_for_file: public_member_api_docs

part of 'error_cubit.dart';

abstract class ErrorState {
  const ErrorState();
}

class NoErrorShown extends ErrorState {}

class UnknownError extends ErrorState {}
