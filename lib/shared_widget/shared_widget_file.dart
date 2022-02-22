import 'package:flutter/material.dart';

class DefaultButtonWidget extends StatelessWidget {
  final String? text;
  final Color? textColor;
  final double? height;
  final double? fontSize;
  final double? horizontalPadding;
  final Color? color;
  final Function()? onPressed;

  const DefaultButtonWidget({
    Key? key,
    required this.text,
    this.height,
    this.color,
    required this.onPressed,
    this.textColor,
    this.horizontalPadding,
    this.fontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: horizontalPadding != null
          ? EdgeInsets.symmetric(horizontal: horizontalPadding!)
          : const EdgeInsets.symmetric(horizontal: 0.0),
      child: MaterialButton(
        minWidth: double.infinity,
        color: color ?? Colors.grey,
        height: height ?? 50.0,
        textColor: textColor ?? Colors.white,
        child: Text(
          text!,
          style: TextStyle(
            fontSize: fontSize ?? 25.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: onPressed,
      ),
    );
  }
}

class DefaultTextFieldWidget extends StatelessWidget {
  final String? hintText ;
  final double? height;
  final double? horizontalPadding;
  final bool? isObscure;
  final Icon? icon;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final bool? isSuffixShow;
  final VoidCallback? suffixOnPressed;
  final IconData? suffixIcon;

  const DefaultTextFieldWidget({
    Key? key,
     this.hintText,
    required this.controller,
    this.isObscure,
    required this.validator,
    this.icon,
    this.height,
    this.horizontalPadding,
    this.isSuffixShow,
    this.suffixOnPressed,
    this.suffixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: horizontalPadding != null
          ? EdgeInsets.symmetric(horizontal: horizontalPadding!)
          : const EdgeInsets.symmetric(horizontal: 0.0),
      child: Container(
        height: height ?? 50.0,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 10,
              offset: const Offset(0, 10),
            )
          ],
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: TextFormField(
            controller: controller,
            obscureText: isObscure ?? false,
            decoration: InputDecoration(
              icon: icon,
              hintText: hintText,
              border: InputBorder.none,
              enabled: true,

              suffixIcon: isSuffixShow != false
                  ? IconButton(
                      icon: Icon(suffixIcon!),
                      splashColor: Colors.transparent,
                      onPressed: suffixOnPressed,
                    )
                  : null,
            ),
            validator: validator),
      ),
    );
  }
}
