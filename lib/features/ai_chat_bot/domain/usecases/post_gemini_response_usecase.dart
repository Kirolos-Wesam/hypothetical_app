import 'package:dartz/dartz.dart';
import 'package:hypothetical_app/core/usecases/base_usecase.dart';
import 'package:hypothetical_app/core/usecases/try_catch.dart';
import 'package:hypothetical_app/features/ai_chat_bot/domain/repositories/ai_chat_bot_repositories.dart';

import '../../../../core/errors/failure.dart';

class PostGeminiResponseUseCase extends BaseUseCase<String, String> {
  final AiChatBotRepositories _aiChatBotRepositories;

  PostGeminiResponseUseCase(this._aiChatBotRepositories);

  @override
  Future<Either<Failure, String>> call(String params) async => await tryCatch(
        tryFunction: () => _aiChatBotRepositories.postGeminiAiContent(params),
      );
}
