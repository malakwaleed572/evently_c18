import 'package:evently/common/gen/assets.gen.dart';
import 'package:evently/common/theme/app_colors.dart';
import 'package:evently/common/theme/widgets/custom_filled_bottom.dart';
import 'package:evently/common/theme/widgets/custom_outlined_buttom.dart';
import 'package:evently/common/theme/widgets/custom_text_field.dart';
import 'package:evently/common/utils/validation_utils.dart';
import 'package:evently/network/auth_service.dart';
import 'package:evently/screens/auth/register_screen.dart';
import 'package:evently/screens/home/home_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const String routeName = "/loginScreen";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: Form(
              key: _formkey,
              child: ListView(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Assets.images.appLogo.image(height: 27, width: 150),
                  ),
                  SizedBox(height: 50),
                  Text(
                    "Login to your account", //TODO localization
                    style: theme.textTheme.displayLarge!.copyWith(
                      color: theme.colorScheme.inversePrimary,
                    ),
                  ),
                  SizedBox(height: 24),
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
                    hintText: "enter your password",
                    prefixIconPath: Assets.icons.lockIcon.path,
                    controller: password,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "empty password";
                      }
                    },
                    isPassword: true,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          "forget password",
                          style: theme.textTheme.labelLarge!.copyWith(
                            color: theme.colorScheme.primary,
                            decoration: TextDecoration.underline,
                            decorationColor: theme.colorScheme.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 50),

                  CustomFilledBottom(
                    isLoading: isLoading,
                    onPressed: () async {
                      if (_formkey.currentState!.validate()) {
                        setState(() {
                          isLoading = true;
                        });

                        String? errorMessage = await AuthService.login(
                          email.text,
                          password.text,
                        );

                        //print("done");
                        setState(() {
                          isLoading = false;
                        });
                        if (errorMessage != null) {
                          //toast
                          Fluttertoast.showToast(
                            msg: errorMessage,
                            backgroundColor: AppColors.red,
                            toastLength: Toast.LENGTH_LONG,
                          );
                        } else {
                          if (context.mounted) {
                            Navigator.pushReplacementNamed(
                              context,
                              HomeScreen.routeName,
                            );
                          }
                        }
                      }
                    },
                    text: "Login",
                  ),
                  SizedBox(height: 50),
                  Center(
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(text: "Dont have an account ? "),
                          TextSpan(
                            text: "Signup",
                            style: theme.textTheme.labelLarge!.copyWith(
                              color: theme.colorScheme.primary,
                              decoration: TextDecoration.underline,
                              decorationColor: theme.colorScheme.primary,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => Navigator.of(
                                context,
                              ).pushReplacementNamed(RegisterScreen.routeName),
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
                          "Login with google",
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
  }
}
