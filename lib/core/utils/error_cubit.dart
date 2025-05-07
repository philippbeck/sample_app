import 'package:flutter_bloc/flutter_bloc.dart';

part 'error_state.dart';

/// Cubit for handling errors
class ErrorCubit extends Cubit<ErrorState> {
  /// Default constructor
  ErrorCubit() : super(NoErrorShown());

  /// Show unknown error
  void showUnknownError() {
    emit(UnknownError());
  }
}
