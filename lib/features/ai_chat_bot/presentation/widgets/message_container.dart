import 'package:animated_text_kit/animated_text_kit.dart';

import 'package:flutter/material.dart';
import 'package:hypothetical_app/core/manager/color_manager.dart';
import 'package:hypothetical_app/core/widgets/custom_text.dart';

class MessageContainer extends StatelessWidget {
  const MessageContainer(
      {super.key,
      required this.backgroundColor,
      required this.message,
      required this.isBot});

  final Color backgroundColor;
  final String message;
  final bool isBot;
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints:
          BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.6),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
                gradient: isBot
                    ? const LinearGradient(
                        begin: Alignment.centerRight,
                        end: Alignment.centerLeft,
                        colors: [
                            ColorsManager.messageFirstColor,
                            ColorsManager.messageCenterColor,
                            ColorsManager.messageCenterColor,
                            ColorsManager.messageCenterColor,
                            ColorsManager.messageFirstColor,
                          ])
                    : null,
                borderRadius: BorderRadius.circular(30),
                color: backgroundColor),
            child: isBot
                ? DefaultTextStyle(
                    style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        color: Colors.black),
                    child: AnimatedTextKit(
                      animatedTexts: [
                        TypewriterAnimatedText(
                          message,
                          speed: const Duration(milliseconds: 50),
                        ),
                      ],
                      totalRepeatCount: 1,
                      displayFullTextOnTap: true,
                      pause: const Duration(milliseconds: 500),
                    ),
                  )
                : Directionality(
                    textDirection: TextDirection.ltr,
                    child: CustomText(
                      message,
                      fontSize: 15,
                      color: isBot ? null : Colors.white,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
