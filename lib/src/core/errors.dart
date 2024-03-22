class EasyArgumentError extends Error {
  final String message;

  EasyArgumentError(this.message);

  @override
  String toString() {
    return 'ArgumentError: $message';
  }
}
