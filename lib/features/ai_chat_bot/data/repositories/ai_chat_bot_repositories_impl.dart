import 'package:hypothetical_app/features/ai_chat_bot/data/datasources/ai_chat_bot_datasources.dart';
import 'package:hypothetical_app/features/ai_chat_bot/domain/repositories/ai_chat_bot_repositories.dart';

class AiChatBotRepositoriesImpl implements AiChatBotRepositories {
  final AiChatBotDatasources _aiChatBotDatasources;

  AiChatBotRepositoriesImpl(
      {required AiChatBotDatasources aiChatBotDatasources})
      : _aiChatBotDatasources = aiChatBotDatasources;

  @override
  Future<String> postGeminiAiContent(String text) async {
    late String content;
    content = await _aiChatBotDatasources.postGeminiAiContent(text);
    return content;
  }
}
