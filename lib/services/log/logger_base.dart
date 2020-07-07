abstract class BaseLogger {
  Future<Null> add();
  Future<Null> reportError(dynamic error, dynamic stackTrace);
}