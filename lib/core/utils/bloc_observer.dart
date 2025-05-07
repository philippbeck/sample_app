import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_app/core/utils/error_logger.dart';

/// Overrides the bloc observer methods to add logging.
class AppBlocObserver extends BlocObserver {
  /// Default constructor
  const AppBlocObserver();

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    ErrorLogger.instance.logInfo('onChange(${bloc.runtimeType}, $change)');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    ErrorLogger.instance.logError(
      file: 'bootstrap',
      event: 'onError',
      error: 'onError(${bloc.runtimeType}, $error)',
      stackTrace: stackTrace,
    );
    super.onError(bloc, error, stackTrace);
  }
}
