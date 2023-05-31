import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_twitter_course/common/common.dart';
import 'package:riverpod_twitter_course/constants/constants.dart';
import 'package:riverpod_twitter_course/features/auth/controller/auth_controller.dart';
import 'package:riverpod_twitter_course/features/auth/view/signup_view.dart';
import 'package:riverpod_twitter_course/features/auth/widgets/auth_field.dart';
import 'package:riverpod_twitter_course/theme/theme.dart';

class LoginView extends ConsumerStatefulWidget {
  static route() => MaterialPageRoute(
        builder: ((context) => const LoginView()),
      );
  const LoginView({super.key});

  @override
  ConsumerState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  final appbar = UIConstants.appBar();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void onLogin() {
    ref.read(authControllerProvider.notifier).login(
        email: emailController.text,
        password: passwordController.text,
        context: context);
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authControllerProvider);
    return Scaffold(
      appBar: appbar,
      body: isLoading
          ? const Loader()
          : Center(
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
                        onTap: onLogin,
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
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.push(context, SignUpView.route());
                              },
                          ),
                        ]))
                  ]),
                ),
              ),
            ),
    );
  }
}
