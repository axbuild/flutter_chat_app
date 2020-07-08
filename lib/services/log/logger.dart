abstract class Logger {
  Future<Null> add();
  Future<Null> reportError(dynamic error, dynamic stackTrace);
}