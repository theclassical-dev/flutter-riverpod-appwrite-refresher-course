import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_twitter_course/common/common.dart';
import 'package:riverpod_twitter_course/constants/constants.dart';
import 'package:riverpod_twitter_course/features/auth/controller/auth_controller.dart';
import 'package:riverpod_twitter_course/features/auth/view/login_view.dart';
import 'package:riverpod_twitter_course/features/auth/widgets/auth_field.dart';

import '../../../theme/theme.dart';

class SignUpView extends ConsumerStatefulWidget {
  static route() => MaterialPageRoute(
        builder: ((context) => const SignUpView()),
      );
  const SignUpView({super.key});

  @override
  ConsumerState<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends ConsumerState<SignUpView> {
  final appbar = UIConstants.appBar();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void onSignUp() {
    ref.read(authControllerProvider.notifier).signUp(
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
                        onTap: onSignUp,
                        label: 'Done',
                      ),
                    ),

                    const SizedBox(
                      height: 40,
                    ),

                    //text
                    RichText(
                        text: TextSpan(
                            text: "Already have an account?",
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                            children: [
                          TextSpan(
                            text: ' Sign In',
                            style: const TextStyle(
                              color: Pallete.blueColor,
                              fontSize: 16,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.push(context, LoginView.route());
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
