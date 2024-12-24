abstract class CrashlyticsService {
  Future<void> init();
  void log(Object exception, StackTrace stackTrace);
}
