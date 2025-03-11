import 'package:animate_do/animate_do.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hypothetical_app/core/manager/color_manager.dart';
import 'package:hypothetical_app/core/widgets/custom_svg.dart';
import 'package:hypothetical_app/core/widgets/custom_text.dart';
import 'package:hypothetical_app/features/ai_chat_bot/presentation/cubit/ai_bot_chat_cubit.dart';

import '../widgets/message_container.dart';

class AIBotChatScreen extends StatelessWidget {
  AIBotChatScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final messageController = TextEditingController();
    return Scaffold(
      appBar: defaultAppBar(title: 'Ai Chat Bot'),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: BlocBuilder<AiBotChatCubit, AiBotChatState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ListView.separated(
                    separatorBuilder: (context, index) => SizedBox(
                      height: 20,
                    ),
                    itemCount:
                        AiBotChatCubit.get(context).aiChatBotQuestions.length,
                    itemBuilder: (context, index) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Directionality(
                          textDirection: TextDirection.rtl,
                          child: SizedBox(
                            width: double.infinity,
                            child: Row(
                              children: [
                                CircleAvatar(
                                  backgroundImage: AssetImage(
                                      'assets/images/profile_image_placeholder.jpg'),
                                  radius: 24,
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                MessageContainer(
                                  backgroundColor: ColorsManager.primaryColor,
                                  message: AiBotChatCubit.get(context)
                                      .aiChatBotQuestions[index],
                                  isBot: false,
                                ),
                              ],
                            ),
                          ),
                        ).fadeInUp(),
                        SizedBox(
                          height: 20,
                        ),
                        ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.7,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(
                                'assets/images/gemini_color.png',
                                width: 60,
                                height: 50,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: AiBotChatCubit.get(context)
                                            .aiChatHistoryTexts
                                            .isNotEmpty &&
                                        index <
                                            AiBotChatCubit.get(context)
                                                .aiChatHistoryTexts
                                                .length
                                    ? MessageContainer(
                                        backgroundColor: Colors.pink,
                                        message: AiBotChatCubit.get(context)
                                            .aiChatHistoryTexts[index],
                                        isBot: true,
                                      )
                                    : state is PostAiChatBotAnswerTextLoadingState
                                        ? Center(
                                            child: Image.asset(
                                              'assets/gif/loading.gif',
                                              width: 50,
                                              height: 100,
                                            ),
                                          )
                                        : const SizedBox(),
                              )
                            ],
                          ),
                        ).fadeInDown(),
                      ],
                    ),
                  ),
                ),
                //const Spacer(),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(60),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: TextFormField(
                            controller: messageController,
                            readOnly:
                                state is PostAiChatBotAnswerTextLoadingState,
                            decoration: const InputDecoration(
                                hintText: 'How I can Help You',
                                border: InputBorder.none),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          if (state is! PostAiChatBotAnswerTextLoadingState) {
                            AiBotChatCubit.get(context)
                                .sendAiChatBotQuestion(messageController.text);
                            AiBotChatCubit.get(context)
                                .postAiChatBotText(messageController.text);
                            messageController.text = '';
                          }
                        },
                        child: Container(
                          width: 70,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: ColorsManager.primaryColor,
                            borderRadius: BorderRadius.circular(60),
                          ),
                          child: const CustomSvg(
                            'assets/icons/send_message_icon.svg',
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }

  AppBar defaultAppBar(
      {required String title,
      bool showBackButton = true,
      Color? backgroundColor,
      List<Widget> actions = const [],
      VoidCallback? onBackPressed}) {
    return AppBar(
      centerTitle: true,
      title: CustomText(
        title,
        fontSize: 28,
        fontWeight: FontWeight.w400,
        color: ColorsManager.primaryColor,
      ),
      actions: actions,
    );
  }
}
