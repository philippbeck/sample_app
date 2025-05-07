import 'package:sample_app/core/utils/dependency_injection.dart';
import 'package:sample_app/core/utils/error_logger.dart';
import 'package:sample_app/core/utils/http_client.dart';
import 'package:sample_app/features/list_view/data/models/content.dart';
import 'package:sample_app/features/list_view/data/models/item.dart';

/// Handles all backend calls associated to the list view.
class ListViewRepository {
  final _httpClient = getIt<HttpClient>();

  /// Fetches the list of items from the backend.
  Future<List<Content>> getListContent(String url) async {
    try {
      final res = await _httpClient.getRequest(url);

      if (res is List) {
        return res
            .map((e) => Content.fromJson(e as Map<String, dynamic>))
            .toList();
      } else {
        throw Error();
      }
    } catch (error, stackTrace) {
      ErrorLogger.instance.logError(
        error: error,
        stackTrace: stackTrace,
        file: 'list_view_repository',
        event: 'getItems',
      );
      return Future.error(error);
    }
  }

  /// Fetches a list of brand items from a given [url].
  Future<List<Item>> getBrandItems(String url) async {
    try {
      final res = await _httpClient.getRequest(url);

      if (res is Map<String, dynamic>) {
        return (res['items'] as List)
            .map((e) => Item.fromJson(e as Map<String, dynamic>))
            .toList();
      } else {
        throw Error();
      }
    } catch (error, stackTrace) {
      ErrorLogger.instance.logError(
        error: error,
        stackTrace: stackTrace,
        file: 'list_view_repository',
        event: 'getBrandItems - $url',
      );
      return Future.error(error);
    }
  }
}
