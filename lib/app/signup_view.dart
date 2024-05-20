import 'package:flutter/material.dart';
import 'package:flutter_application_akhir/common/color_common.dart';
import 'package:flutter_application_akhir/widget/round_button.dart';
import 'package:flutter_application_akhir/widget/round_textfield.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: TColor.primaryColor1,
      body: SafeArea(child: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 28),
            child:  Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                   Text(
                    'Sign Up',
                    style: TextStyle(color: TColor.gray, fontSize: 24),
                  ),
                  const SizedBox(height: 20),
                  const RoundTextField(
                    icon: Icons.person,
                    hitText: "Full Name",
                  ),
                  const SizedBox(height: 16),
                  const RoundTextField(
                    icon: Icons.email,
                    hitText: "Email",
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 16),
                  const RoundTextField(
                    icon: Icons.lock,
                    hitText: "Password",
                    obscureText: true, // Hide password by default
                  ),
                  const SizedBox(height: 16), // Optional: Add space before button
                  RoundButton(
                    title: "Sign Up",
                    onPressed: () {
                      // Add your sign-up logic here
                    },
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account?',
                        style: TextStyle(color: TColor.white),
                      ),
                      SizedBox(width: 10),
                      GestureDetector(
                        onTap: () {
                          // Navigate back to login page
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Login',
                          style: TextStyle(
                            color: TColor.secondary1,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
            ),
          ),
        ),
      )),
    );
  }
}
