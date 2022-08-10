class Throwable implements Exception {
  final String? error;
  final int? statusCode;

  Throwable({this.error, this.statusCode});

  @override
  String toString() {
    return error ?? "";
  }
}
