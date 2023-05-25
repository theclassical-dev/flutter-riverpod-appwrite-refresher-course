import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_twitter_course/common/rounded_small_button.dart';
import 'package:riverpod_twitter_course/constants/ui_constants.dart';
import 'package:riverpod_twitter_course/features/auth/widgets/auth_field.dart';
import 'package:riverpod_twitter_course/theme/theme.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final appbar = UIConstants.appBar();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(children: [
              //textfeild
              AuthField(
                controller: emailController,
                hintText: 'Email',
              ),

              const SizedBox(
                height: 20,
              ),

              //textfeild password
              AuthField(
                controller: passwordController,
                hintText: 'Password',
              ),

              const SizedBox(
                height: 40,
              ),
              //button
              Align(
                alignment: Alignment.topRight,
                child: RoundSmallButton(
                  onTap: () {},
                  label: 'Done',
                ),
              ),

              const SizedBox(
                height: 40,
              ),

              //text
              RichText(
                  text: TextSpan(
                      text: "Dont have an account?",
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                      children: [
                    TextSpan(
                      text: ' Sign Up',
                      style: const TextStyle(
                        color: Pallete.blueColor,
                        fontSize: 16,
                      ),
                      recognizer: TapGestureRecognizer()..onTap = () {},
                    ),
                  ]))
            ]),
          ),
        ),
      ),
    );
  }
}
