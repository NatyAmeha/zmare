import 'package:jwt_decode/jwt_decode.dart';

abstract class IJWTDecoder {
  Map<String, dynamic> decodeToken(String token);
  DateTime? getExpiryDate(token);
  bool isTokenExpired(token);
}

class JwtDecoder implements IJWTDecoder {
  const JwtDecoder();
  @override
  Map<String, dynamic> decodeToken(String token) {
    var parsedValue = Jwt.parseJwt(token);
    return parsedValue;
  }

  @override
  DateTime? getExpiryDate(token) {
    var result = Jwt.getExpiryDate(token);
    return result;
  }

  @override
  bool isTokenExpired(token) {
    return Jwt.isExpired(token);
  }
}
