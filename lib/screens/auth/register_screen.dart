import 'package:evently/common/models/custom_user_model.dart';
import 'package:evently/common/utils/validation_utils.dart';
import 'package:evently/network/auth_service.dart';
import 'package:evently/screens/auth/login_screen.dart';
import 'package:evently/screens/home/home_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:evently/common/gen/assets.gen.dart';
import 'package:evently/common/theme/app_colors.dart';
import 'package:evently/common/theme/widgets/custom_filled_bottom.dart';
import 'package:evently/common/theme/widgets/custom_outlined_buttom.dart';
import 'package:evently/common/theme/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  static const String routeName = "/registerScreen";

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController reEnterPassword = TextEditingController();
  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      body: Form(
        key: _globalKey,
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: ListView(
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Assets.images.appLogo.image(height: 27, width: 150),
                  ),
                  SizedBox(height: 50),
                  Text(
                    "Create your account", //TODO localization
                    style: theme.textTheme.displayLarge!.copyWith(
                      color: theme.colorScheme.inversePrimary,
                    ),
                  ),
                  SizedBox(height: 24),
                  CustomTextField(
                    hintText: "enter your name",
                    prefixIconPath: Assets.icons.userRegester.path,
                    controller: name,
                    validator: (value) {
                      if (ValidationUtils.validateEmptyText(value) == false) {
                        return "empty name";
                      }
                    },
                  ),
                  SizedBox(height: 16),
                  CustomTextField(
                    hintText: "enter your email",
                    prefixIconPath: Assets.icons.sms.path,
                    controller: email,
                    validator: (value) {
                      if (ValidationUtils.validateEmptyText(value) == false) {
                        return "empty email";
                      } else if (ValidationUtils.validateEmail(value!) ==
                          false) {
                        return "invalid email";
                      }
                    },
                  ),
                  SizedBox(height: 16),
                  CustomTextField(
                    hintText: "confirm your password",
                    prefixIconPath: Assets.icons.lockIcon.path,
                    isPassword: true,
                    controller: password,
                    validator: (value) {
                      if (ValidationUtils.validateEmptyText(value) == false) {
                        return "empty password";
                      } else if (ValidationUtils.validatePassword(value!) ==
                          false) {
                        return "invalid password ,at least 5characters";
                      }
                    },
                  ),
                  SizedBox(height: 16),

                  CustomTextField(
                    hintText: "confirm your password",
                    prefixIconPath: Assets.icons.lockIcon.path,
                    isPassword: true,
                    controller: reEnterPassword,
                    validator: (value) =>
                        value != password.text ? "password doesnt match" : null,
                  ),
                  SizedBox(height: 50),

                  CustomFilledBottom(
                    isLoading: isLoading,
                    onPressed: () async {
                      if (_globalKey.currentState!.validate()) {
                        setState(() {
                          isLoading = true;
                        });
                        String? errorMessage = await AuthService.register(
                         CustomUserModel(email: email.text,name: name.text),
                          password.text,
                        );
                        setState(() {
                          isLoading = true;
                        });
                        if (errorMessage != null) {
                          Fluttertoast.showToast(
                            msg: "This account alredy exist with this email",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: AppColors.red,
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );
                        } else {
                          if (context.mounted) {
                            Navigator.of(
                              context,
                            ).pushReplacementNamed(LoginScreen.routeName);
                          }
                        }
                      }
                    },
                    text: "Sign up",
                  ),
                  SizedBox(height: 50),
                  Center(
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(text: "Dont have an account ? "),
                          TextSpan(
                            text: "Login",
                            style: theme.textTheme.labelLarge!.copyWith(
                              color: theme.colorScheme.primary,
                              decoration: TextDecoration.underline,
                              decorationColor: theme.colorScheme.primary,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => Navigator.of(
                                context,
                              ).pushReplacementNamed(LoginScreen.routeName),
                          ),
                        ],
                        style: theme.textTheme.labelSmall!.copyWith(
                          color: theme.hintColor,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 32),

                  Center(
                    child: Text(
                      "OR",
                      style: theme.textTheme.titleLarge!.copyWith(
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  ),
                  SizedBox(height: 32),
                  CustomOutlinedBottom(
                    onPressed: () {},
                    child: Row(
                      spacing: 16,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Assets.images.googleIcon.image(height: 24, width: 24),
                        Text(
                          "Sign up with google",
                          style: theme.textTheme.headlineMedium!.copyWith(
                            color: theme.colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
    ;
  }
}
