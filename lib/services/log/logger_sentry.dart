import 'package:chatapp/business_logic/models/global_config.dart';
import 'package:chatapp/services/log/logger.dart';
import 'package:sentry/sentry.dart';

final GlobalConfig globalConfig = GlobalConfig();
final SentryClient _sentry = SentryClient(dsn: globalConfig.sentryDsn);

class SentryLogger implements Logger {

  @override
   Future<Null> reportError(dynamic error, dynamic stackTrace) async {
    print('Caught error: $error');

    print('Reporting to Sentry.io...');

    final SentryResponse response = await _sentry.captureException(
      exception: error,
      stackTrace: stackTrace,
    );

    if (response.isSuccessful) {
      print('Success! Event ID: ${response.eventId}');
    } else {
      print('Failed to report to Sentry.io: ${response.error}');
    }
  }

  @override
  Future<Null> add() {
    // TODO: implement add
    throw UnimplementedError();
  }
}