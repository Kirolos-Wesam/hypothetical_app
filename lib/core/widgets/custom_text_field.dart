import 'package:flutter/material.dart';
import 'package:hypothetical_app/core/theme/themes_manager.dart';

import '/core/manager/color_manager.dart';
import '../extensions/responsive_manager.dart';
import '../manager/values_manager.dart';
import 'custom_svg.dart';

class CustomTextField extends StatefulWidget {
  final String? hintText;
  final TextEditingController controller;
  final TextInputType textInputType;
  final Function(String newValue)? onChanged;
  final Widget? leftIcon;
  final String? svgIcon;
  final Widget? rightIcon;
  final String? Function(String? value)? validator;
  final FocusNode? focusNode;
  final TextAlign textAlign;
  final int? maxLength;
  final InputBorder? border;
  final InputBorder? focusedBorder;

  const CustomTextField({
    Key? key,
    this.hintText,
    this.rightIcon,
    required this.controller,
    required this.textInputType,
    this.onChanged,
    this.leftIcon,
    this.validator,
    this.border,
    this.focusNode,
    this.focusedBorder,
    this.maxLength,
    this.textAlign = TextAlign.start,
    this.svgIcon,
  }) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      keyboardType: widget.textInputType,
      cursorColor: ColorsManager.primaryColor,
      onChanged: widget.onChanged,
      focusNode: widget.focusNode,
      textAlign: widget.textAlign,
      maxLength: widget.maxLength,
      obscureText: widget.textInputType == TextInputType.visiblePassword
          ? _obscureText
          : false,
      style: ThemesManager.getBodySmallTextStyle(context),
      decoration: InputDecoration(
        border: widget.border,
        focusedBorder: widget.focusedBorder,
        suffixIcon: widget.textInputType == TextInputType.visiblePassword
            ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                  color: Theme.of(context).iconTheme.color,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              )
            : widget.rightIcon,
        prefixIcon: widget.leftIcon ??
            (widget.svgIcon == null
                ? null
                : Padding(
                    padding: EdgeInsetsDirectional.symmetric(
                      horizontal: PaddingValues.p15.rw,
                    ),
                    child: CustomSvg(
                      widget.svgIcon!,
                      color: Theme.of(context)
                          .inputDecorationTheme
                          .suffixIconColor,
                    ),
                  )),
        hintText: widget.hintText,
      ),
    );
  }
}
