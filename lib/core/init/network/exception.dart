class ApiException implements Exception {
  final String message;
  final int code;

  ApiException({required this.message, required this.code});

  @override
  String toString() => '$message ($code)';
}

class BadRequestException extends ApiException {
  BadRequestException({required String message, required int code})
      : super(message: message, code: code);
}

class UnauthorizedException extends ApiException {
  UnauthorizedException({required String message, required int code})
      : super(message: message, code: code);
}

class ForbiddenException extends ApiException {
  ForbiddenException({required String message, required int code})
      : super(message: message, code: code);
}

class NotFoundException extends ApiException {
  NotFoundException({required String message, required int code})
      : super(message: message, code: code);
}

class ServerException extends ApiException {
  ServerException({required String message, required int code})
      : super(message: message, code: code);
}

class ClientException extends ApiException {
  ClientException({required String message, required int code})
      : super(message: message, code: code);
}

class NoInternetException extends ApiException {
  NoInternetException({required String message, required int code})
      : super(message: message, code: code);
}