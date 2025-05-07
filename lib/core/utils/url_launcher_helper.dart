import 'package:sample_app/core/utils/error_logger.dart';
import 'package:url_launcher/url_launcher.dart';

/// Helper class for launching an url from the app.
class UrlLauncherHelper {
  /// Opens up the browser with the given [url] in the given [launchMode].
  static Future<void> openUrl({
    required String url,
    LaunchMode launchMode = LaunchMode.externalApplication,
  }) async {
    try {
      final uri = Uri.parse(url);
      await launchUrl(uri, mode: launchMode);
    } catch (error, stackTrace) {
      ErrorLogger.instance.logError(
        error: error,
        stackTrace: stackTrace,
        file: 'url_launcher_helper',
        event: 'openUrl',
      );
      return Future.error(error);
    }
  }
}
