import 'package:flutter/material.dart';
import 'package:flutter_application_akhir/app/mainapp/main_view.dart';
import 'package:flutter_application_akhir/app/signup_view.dart';
import 'package:flutter_application_akhir/widget/round_button.dart';
import 'package:flutter_application_akhir/widget/round_textfield.dart';
import 'package:flutter_application_akhir/common/color_common.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_akhir/app/service/auth.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool isPasswordVisible = false;
  String? errorMessage = '';

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  
  Future<void> signInEmailAndPassword() async {
    try {
      await Auth().signInWithEmailAndPassword(email: _controllerEmail.text, password: _controllerPassword.text);
    } on FirebaseAuthException catch (e){
      setState(() {
        errorMessage = e.message;
      });
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
                children: <Widget> [
                  Text(
                    'Welcome Back',
                    style: TextStyle(color: TColor.gray, fontSize: 24),
                  ),
                  const SizedBox(height: 20),
                   RoundTextField(
                    icon: Icons.email,
                    hitText: "Email",
                    controller: _controllerEmail,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 16),
                  RoundTextField(
                    obscureText: !isPasswordVisible,
                    hitText: "Password",
                    icon: Icons.lock,
                    controller: _controllerPassword,
                    rigtIcon: IconButton(
                      icon: Icon(
                        isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          isPasswordVisible = !isPasswordVisible;
                        });
                      },
                    ),
                  ),
                  SizedBox(height: media.height * 0.004),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Create Account',
                        style: TextStyle(color: TColor.white),
                      ),
                      const SizedBox(width: 5),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUpView()) );
                        },
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            color:
                                TColor.secondary1,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: media.height * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                            width: 50,
                            height: 50,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: TColor.white,
                                border: Border.all(
                                    width: 1,
                                    color: TColor.gray.withOpacity(0.4)),
                                borderRadius: BorderRadius.circular(15)),
                            child: const FaIcon(
                              FontAwesomeIcons.facebook,
                              size: 20,
                            )),
                      ),
                      SizedBox(
                        width: media.width * 0.04,
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                            width: 50,
                            height: 50,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: TColor.white,
                                border: Border.all(
                                    width: 1,
                                    color: TColor.gray.withOpacity(0.4)),
                                borderRadius: BorderRadius.circular(15)),
                            child: IconButton(
                              icon: const FaIcon(FontAwesomeIcons.google),
                              onPressed: () {},
                            )),
                      )
                    ],
                  ),

                  SizedBox(
                    height: media.height * 0.04,
                  ),

                  RoundButton(title: "Login", onPressed: () {
                    signInEmailAndPassword();
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
