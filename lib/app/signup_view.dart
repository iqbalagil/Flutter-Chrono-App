import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_akhir/app/service/auth.dart';
import 'package:flutter_application_akhir/common/color_common.dart';
import 'package:flutter_application_akhir/widget/round_button.dart';
import 'package:flutter_application_akhir/widget/round_textfield.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  String? errorMessage = '';

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final TextEditingController _controllerUsername = TextEditingController();

  @override
  void dispose() {
    _controllerEmail.dispose();
    _controllerPassword.dispose();
    _controllerUsername.dispose();
    super.dispose();
  }

  Future<void> signUpWithEmailAndPassword() async {
    if (_controllerEmail.text.isEmpty ||
        _controllerPassword.text.isEmpty ||
        _controllerUsername.text.isEmpty) {
      setState(() {
        errorMessage = "Please fill out all fields";
      });
      return;
    }

    try {
      await Auth().signUpWithEmailAndPassword(
        username: _controllerUsername.text,
        email: _controllerEmail.text,
        password: _controllerPassword.text,
      );
      setState(() {
        errorMessage = 'Sign up successful! Please login.';
      });
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
      print('FirebaseAuthException: ${e.message}');
    } catch (e) {
      setState(() {
        errorMessage = "An unexpected error occurred";
      });
      print('Sign up error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: TColor.primaryColor1,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Sign Up',
                    style: TextStyle(color: TColor.gray, fontSize: 24),
                  ),
                  const SizedBox(height: 20),
                  RoundTextField(
                    icon: Icons.person,
                    hitText: "Full Name",
                    controller: _controllerUsername,
                  ),
                  const SizedBox(height: 16),
                  RoundTextField(
                    icon: Icons.email,
                    hitText: "Email",
                    controller: _controllerEmail,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 16),
                  RoundTextField(
                    icon: Icons.lock,
                    controller: _controllerPassword,
                    hitText: "Password",
                    obscureText: true,
                  ),
                  if (errorMessage != null && errorMessage!.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Text(
                        errorMessage!,
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  const SizedBox(height: 16),
                  RoundButton(
                    title: "Sign Up",
                    onPressed: signUpWithEmailAndPassword,
                  ),
                  SizedBox(height: media.height * 0.04),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account?',
                        style: TextStyle(color: TColor.white),
                      ),
                      const SizedBox(width: 10),
                      GestureDetector(
                        onTap: () {
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
        ),
      ),
    );
  }
}
