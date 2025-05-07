import 'dart:developer' as developer;
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';

/// Logs errors when something went wrong
class ErrorLogger {
  ErrorLogger._();
  static final ErrorLogger _singleton = ErrorLogger._();

  /// Gets the singleton [instance] of [ErrorLogger]
  static ErrorLogger get instance => _singleton;

  /// Logs an [error] and a [stackTrace] in a specific [file] during a specific [event].
  Future<void> logError({
    required dynamic error,
    StackTrace? stackTrace,
    required String file,
    required String event,
  }) async {
    stackTrace ??= StackTrace.current;
    if (kDebugMode) {
      developer.log(
        'Error occurred in file: $file inside event: $event',
        error: error,
        stackTrace: stackTrace,
        level: _getLevel(error).value,
      );
    }
  }

  /// Logs a warning with a [stackTrace] in a specific [file] during a specific [event].
  void logWarning({
    StackTrace? stackTrace,
    required String file,
    required String event,
    required String warning,
  }) {
    stackTrace ??= StackTrace.current;
    if (kDebugMode) {
      developer.log(
        'Warning occurred in file: $file inside event: $event',
        stackTrace: stackTrace,
        level: Level.WARNING.value,
        error: warning,
      );
    }
  }

  /// Logs an info.
  void logInfo(String info) {
    if (kDebugMode) {
      developer.log(info, level: Level.INFO.value);
    }
  }

  static Level _getLevel(Object? error) {
    if (error is DioException) {
      return Level.INFO;
    }
    return Level.SEVERE;
  }
}
