import 'package:shelf/shelf.dart';

abstract class SecurityService<T> {
  Future<String> generateJWT(String userID);
  Future<T?> validateJWT(String userID);

  Middleware get verifyJWT;
  Middleware get authorization;
}
