import 'package:get_it/get_it.dart';
import 'package:sample_app/core/utils/error_cubit.dart';
import 'package:sample_app/core/utils/error_logger.dart';
import 'package:sample_app/core/utils/http_client.dart';
import 'package:sample_app/features/list_view/data/repositories/list_view_repository.dart';

/// Instance of get it dependency injection lib
final getIt = GetIt.instance;

/// Setup dependency injection
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

  /// Try to register ListViewRepository
  if (!getIt.isRegistered<ListViewRepository>()) {
    ErrorLogger.instance.logInfo(
      'Trying to register ListViewRepository singleton...',
    );
    getIt.registerSingleton<ListViewRepository>(ListViewRepository());
    ErrorLogger.instance.logInfo(
      'Successfully registered ListViewRepository singleton.',
    );
  } else {
    ErrorLogger.instance.logInfo(
      'ListViewRepository singleton already registered.',
    );
  }
}
