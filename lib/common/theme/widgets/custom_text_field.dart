import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    this.titleText,
    required this.hintText,
    this.prefixIconPath,
    this.controller,
    this.maxLines=1,
    this.validator,
    this.isPassword = false,
  });
  final String hintText;
  final int? maxLines;
  final String? titleText;
  final String? prefixIconPath;
  final bool isPassword;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _isSvg(String path) => path.contains(".svg");
  late bool isObsecured = widget.isPassword;
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        if (widget.titleText != null)
          Text(widget.titleText ?? '', style: theme.textTheme.titleMedium),
        TextFormField(
          controller: widget.controller,
          obscureText: isObsecured,
          enableSuggestions: !widget.isPassword,
          autocorrect: !widget.isPassword,
          validator: widget.validator,
          onTapOutside: (event) => FocusScope.of(context).unfocus(),
         maxLength:widget.maxLines ,
          decoration: InputDecoration(

            hintText: widget.hintText,
            filled: true,
            fillColor: theme.cardColor,
            prefixIcon: widget.prefixIconPath == null
                ? null
                : Padding(
                    padding: EdgeInsetsGeometry.only(
                      left: 16,
                      top: 12,
                      bottom: 12,
                      right: 8,
                    ),
                    child: _isSvg(widget.prefixIconPath!)
                        ? SvgPicture.asset(
                            widget.prefixIconPath!,
                            colorFilter: ColorFilter.mode(
                              theme.disabledColor,
                              BlendMode.srcIn,
                            ),
                          )
                        : Image.asset(
                            widget.prefixIconPath!,
                            color: theme.disabledColor,
                          ),
                  ),
            suffixIcon: widget.isPassword
                ? InkWell(
                    onTap: () {
                      setState(() {
                        isObsecured = !isObsecured;
                      });
                    },
                    child: Icon(
                      isObsecured
                          ? Icons.visibility_off_outlined
                          : Icons.remove_red_eye_outlined,
                      color: theme.disabledColor,
                    ),
                  )
                : null,
            hintStyle: theme.textTheme.labelSmall!.copyWith(
              color: theme.hintColor,
            ),
            border: _generateBorderStyle(theme),
            enabledBorder: _generateBorderStyle(theme),
            focusedBorder: _generateBorderStyle(
              theme,
              color: theme.colorScheme.primary,
            ),
          ),
        ),
      ],
    );
  }

  _generateBorderStyle(ThemeData theme, {Color? color}) => OutlineInputBorder(
    borderSide: BorderSide(color: color ?? theme.dividerColor),
    borderRadius: BorderRadius.circular(16),
  );
}
