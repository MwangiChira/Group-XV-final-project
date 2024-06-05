// chatbot_service NPL library using dialogflow_flutter
import 'package:dialogflow_flutter/dialogflow_flutter.dart';
import 'package:flutter/material.dart';

class ChatbotService {
  final _dialogflow = Dialogflow(
    authenticationGoogle: AuthGoogle(
      secret: 'your_google_cloud_api_key_here',
      clienId: 'your_google_cloud_client_id_here',
    ),
  );

  Future<String> sendMessageToChatbot(String message) async {
    try {
      final result = await _dialogflow.detectIntent(message);
      return result.getMessage() ?? 'Sorry, I could not understand that.';
    } catch (error) {
      print('Error talking to chatbot: $error');
      return 'Sorry, there was an error talking to the chatbot.';
    }
  }
}
