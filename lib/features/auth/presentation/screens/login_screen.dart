import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hypothetical_app/core/extensions/padding_manager.dart';
import 'package:hypothetical_app/core/extensions/responsive_manager.dart';
import 'package:hypothetical_app/core/manager/assets_manager.dart';
import 'package:hypothetical_app/core/manager/values_manager.dart';
import 'package:hypothetical_app/core/widgets/custom_text.dart';
import 'package:hypothetical_app/core/widgets/custom_text_field.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(20.rs)),
            child: Center(
                child: Image.asset(
              AssetsManager.appIcon,
              width: 150.rw,
              height: 150.rh,
            )),
          ),
          AppSize.s20.verticalSpace,
          const CustomText(
            'Welcome To Hypothetical App',
          ),
          AppSize.s20.verticalSpace,
          CustomTextField(
            controller: emailController,
            textInputType: TextInputType.phone,
            hintText: 'Email',
          ),
          AppSize.s10.verticalSpace,
          CustomTextField(
              controller: passwordController,
              hintText: 'Password',
              textInputType: TextInputType.visiblePassword),
        ],
      ).withPadding(PaddingValues.p10.pAll),
    );
  }
}
