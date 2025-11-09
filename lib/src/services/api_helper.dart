import 'package:http/http.dart' as http;

class ApiHelper {
  static const baseUrl = 'http://10.0.2.2:3000/api';

  static Map<String, String> headers(String? token) => {
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      };
}
