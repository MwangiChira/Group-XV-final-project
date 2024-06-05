// instant warning alerts using flutter_sms
import 'package:flutter_sms/flutter_sms.dart';

class AlertService {
  Future<void> sendEmergencySMS(
      String message, List<String> recipientNumbers) async {
    try {
      await sendSMS(message: message, recipients: recipientNumbers);
    } catch (error) {
      print('Error sending SMS: $error');
    }
  }
}
