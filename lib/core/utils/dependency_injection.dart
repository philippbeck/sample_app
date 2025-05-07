import 'package:get_it/get_it.dart';
import 'package:sample_app/core/utils/error_cubit.dart';
import 'package:sample_app/core/utils/error_logger.dart';
import 'package:sample_app/core/utils/http_client.dart';

/// Instance of get it dependency injection lib
final getIt = GetIt.instance;

Future<void> setup(ErrorCubit errorCubit) async {
  /// Try to register HttpClient
  if (!getIt.isRegistered<HttpClient>()) {
    ErrorLogger.instance.logInfo('Trying to register HttpClient singleton...');
    getIt.registerSingleton<HttpClient>(HttpClient(errorCubit: errorCubit));
    ErrorLogger.instance.logInfo(
      'Successfully registered HttpClient singleton.',
    );
  } else {
    ErrorLogger.instance.logInfo('HttpClient singleton already registered.');
  }
}
