import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hypothetical_app/core/extensions/border_manager.dart';
import 'package:hypothetical_app/core/extensions/durations.dart';
import 'package:hypothetical_app/core/extensions/padding_manager.dart';
import 'package:hypothetical_app/core/extensions/responsive_manager.dart';

import '../../../../core/manager/color_manager.dart';
import '../../../../core/manager/values_manager.dart';
import '../../../../core/theme/themes_manager.dart';
import '../../../../core/widgets/custom_container.dart';
import '../../../../core/widgets/custom_text.dart';
import '../../../../core/widgets/loading.dart';

class LoginLoadingButton extends StatelessWidget {
  const LoginLoadingButton(
      {Key? key,
      required this.isLoading,
      required this.onTap,
      required this.title})
      : super(key: key);

  final bool isLoading;
  final VoidCallback onTap;
  final String title;

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      onTap: onTap,
      haveShadows: true,
      width: isLoading ? AppSize.s70.rw : ScreenUtil().screenWidth,
      height: AppSize.s55.rh,
      borderRadius: isLoading ? BorderValues.b45.borderAll : null,
      padding: PaddingValues.p15.pAll,
      duration: DurationValues.dm250.milliseconds,
      child: isLoading
          ? const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomLoading(
                  color: ColorsManager.whiteColor,
                ),
              ],
            )
          : Align(
              alignment: Alignment.center,
              child: CustomText(title,
                  textStyle: ThemesManager.getBodySmallTextStyle(context),
                  color: ColorsManager.whiteColor,
                  fontWeight: FontWeight.bold),
            ),
    );
  }
}
