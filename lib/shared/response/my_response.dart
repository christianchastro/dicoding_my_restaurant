class MyResponse {
  final bool _error;
  final String _message;
  const MyResponse(this._error, this._message);

  bool get error => _error;
  String get message => _message;
}
