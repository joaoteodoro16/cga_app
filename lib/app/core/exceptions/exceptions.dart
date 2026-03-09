class AppException implements Exception {
  final String message;
  AppException({required this.message});
}

class UnauthorizedException extends AppException{
  UnauthorizedException({required super.message});
}


class AppRestClientException extends AppException {
  final int? statusCode;
  final dynamic data;
  AppRestClientException({required super.message, this.statusCode, this.data});
}


