import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static Future<void> submitReport(ReportModel report, Position position) async {
    final url = 'https://example.com/api/reports'; // replace with your API endpoint
    final headers = {
      'Content-Type': 'application/json',
    };
    final body = jsonEncode({
      'description': report.description,
      'location': report.location,
      'latitude': position.latitude,
      'longitude': position.longitude,
    });

    final response = await http.post(Uri.parse(url), headers: headers, body: body);

    if (response.statusCode == 201) {
      print('Report submitted successfully');
    } else {
      print('Error submitting report: ${response.statusCode}');
    }
  }
}
