import '../../../../core/api/api_consumer.dart';

abstract class AiChatBotDatasources {
  Future<String> postGeminiAiContent(String text);
}

class AiChatBotDatasourcesImpl implements AiChatBotDatasources {
  final ApiConsumer _apiConsumer;

  AiChatBotDatasourcesImpl({required ApiConsumer apiConsumer})
      : _apiConsumer = apiConsumer;

  @override
  Future<String> postGeminiAiContent(String text) async {
    final requestData = {
      "contents": [
        {
          "parts": [
            {"text": text}
          ]
        }
      ]
    };
    final response = await _apiConsumer.postData(
        url: '',
        data: requestData,
        query: {'key': 'AIzaSyAYK4lC3ZNj8gjpDTe1w-eHfCmR7d8MZJg'});
    return response.data['candidates'][0]['content']['parts'][0]['text'];
  }
}
