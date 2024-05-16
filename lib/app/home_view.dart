import 'package:flutter/material.dart';
import 'package:flutter_application_akhir/common/color_common.dart';
import 'package:flutter_application_akhir/widget/round_button.dart'; // Adjust the import path if necessary

class HomeBoarding extends StatefulWidget {
  const HomeBoarding({super.key});

  @override
  State<HomeBoarding> createState() => _HomeBoardingState();
}

class _HomeBoardingState extends State<HomeBoarding> {
  bool isChangeColor = false;

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: TColor.primaryColor1,
      body: Container(
        width: media.width,
        decoration: BoxDecoration(
          gradient: isChangeColor
              ? LinearGradient(
                  colors: TColor.primaryG,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : null,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                Image.asset(
                  '../asset/img/chronolg.png',
                  width: media.width * 0.7, // Adjust the width as needed
                ),
                Text(
                  "Chrono Watch",
                  style: TextStyle(
                    color: TColor.white,
                    fontSize: 37,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  "Trigger the time",
                  style: TextStyle(
                    color: TColor.gray,
                    fontSize: 16,
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(bottom: 30.0),
                  child: RoundButton(
                    title: "Get Started",
                    type: RoundButtonType.bgGradient,
                    onPressed: () {
                      // Define the action for the button here
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
