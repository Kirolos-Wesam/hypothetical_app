import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hypothetical_app/core/extensions/padding_manager.dart';
import 'package:hypothetical_app/core/extensions/responsive_manager.dart';
import 'package:hypothetical_app/core/manager/assets_manager.dart';
import 'package:hypothetical_app/core/manager/values_manager.dart';
import 'package:hypothetical_app/core/widgets/custom_text.dart';
import 'package:hypothetical_app/core/widgets/custom_text_field.dart';
import 'package:hypothetical_app/core/widgets/toast.dart';
import 'package:hypothetical_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:hypothetical_app/features/auth/presentation/widgets/login_loading_button.dart';

import '../../../../core/routes/routes.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final confirmPasswordController = TextEditingController();
    final dateController = TextEditingController();
    final phoneContoller = TextEditingController();
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: ScreenUtil().statusBarHeight,
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              BackButton(),
            ],
          ),
          Center(
            child: Image.asset(
              AssetsManager.appIcon,
              width: 150.rw,
              height: 150.rh,
            ),
          ),
          AppSize.s10.verticalSpace,
          const CustomText('Create Account'),
          AppSize.s15.verticalSpace,
          CustomTextField(
              hintText: 'Name',
              controller: nameController,
              textInputType: TextInputType.name),
          AppSize.s10.verticalSpace,
          CustomTextField(
              hintText: 'Email',
              controller: emailController,
              textInputType: TextInputType.emailAddress),
          AppSize.s10.verticalSpace,
          CustomTextField(
              hintText: 'Password',
              controller: passwordController,
              textInputType: TextInputType.visiblePassword),
          AppSize.s20.verticalSpace,
          BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is CreateAccountSuccessState) {
                AuthBloc.get(context).add(CreateAccountFireStoreEvent(
                    email: emailController.text,
                    userName: nameController.text,
                    phoneNumber: phoneContoller.text,
                    useId: state.createAccountId,
                    birthDate: dateController.text));
              }
              if (state is CreateAccountFireStoreSuccessState) {
                Navigator.pushNamed(context, Routes.aiChatBotScreen);
              }
              if (state is CreateAccountErrorState) {
                showToast(state.error, backGroundColor: Colors.red);
              }
            },
            builder: (context, state) {
              return LoginLoadingButton(
                isLoading: state is CreateAccountLoadingState,
                onTap: () {
                  AuthBloc.get(context).add(CreateAccountEvent(
                      email: emailController.text,
                      password: passwordController.text));
                },
                title: 'Create Account',
              );
            },
          )
        ],
      ).withPadding(PaddingValues.p15.pAll)),
    );
  }
}
