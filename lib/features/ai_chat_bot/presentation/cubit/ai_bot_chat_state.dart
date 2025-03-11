part of 'ai_bot_chat_cubit.dart';

sealed class AiBotChatState {
  const AiBotChatState();
}

final class AiBotChatInitial extends AiBotChatState {}

class PostAiChatBotAnswerTextLoadingState extends AiBotChatState {}

class PostAiChatBotTextSuccessState extends AiBotChatState {
  final String text;
  PostAiChatBotTextSuccessState(this.text);
}

class PostAiChatBotTextErrorState extends AiBotChatState {
  final String error;

  PostAiChatBotTextErrorState(this.error);
}

class SendAiChatBotTextState extends AiBotChatState {
  final List<String> texts;

  SendAiChatBotTextState(this.texts);
}

class RemoveAiChatBotTextState extends AiBotChatState {
  final List<String> texts;

  RemoveAiChatBotTextState(this.texts);
}
