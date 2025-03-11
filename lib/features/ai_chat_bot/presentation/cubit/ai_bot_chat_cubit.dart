import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hypothetical_app/features/ai_chat_bot/domain/usecases/post_gemini_response_usecase.dart';

part 'ai_bot_chat_state.dart';

class AiBotChatCubit extends Cubit<AiBotChatState> {
  final PostGeminiResponseUseCase postGeminiResponseUseCase;

  AiBotChatCubit(this.postGeminiResponseUseCase) : super(AiBotChatInitial());

  static AiBotChatCubit get(context) =>
      BlocProvider.of<AiBotChatCubit>(context);

  String? textResponse;
  List<String> aiChatHistoryTexts = [];
  List<String> aiChatBotQuestions = [];
  void postAiChatBotText(String params) async {
    emit(PostAiChatBotAnswerTextLoadingState());
    final result = await postGeminiResponseUseCase(params);
    result.fold((failure) {
      emit(PostAiChatBotTextErrorState(failure.message!));
    }, (data) {
      textResponse = data;

      if (textResponse != null) {
        aiChatHistoryTexts.addAll([textResponse!]);
      }

      emit(PostAiChatBotTextSuccessState(data));
    });
  }

  void sendAiChatBotQuestion(String question) {
    aiChatBotQuestions.add(question);
    emit(SendAiChatBotTextState(aiChatBotQuestions));
  }

  //do that if the message have been not send to bot
  void removeAiChatBotQuestion(String question) {
    aiChatBotQuestions.remove(question);
    emit(RemoveAiChatBotTextState(aiChatBotQuestions));
  }
}
