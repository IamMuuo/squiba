mixin ApiService {
  static const Map<String, String> headers = {
    "Content-Type": "application/json",
  };

  static const String urlPrefix = "http://localhost:8000";
}
