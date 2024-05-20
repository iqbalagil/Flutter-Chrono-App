import 'package:flutter/material.dart';
import 'package:flutter_application_akhir/common/color_common.dart';

enum RoundButtonType { bgGradient, bgSGradient , textGradient }

class RoundButton extends StatelessWidget {
  final String title;
  final RoundButtonType type;
  final VoidCallback onPressed;
  final double fontSize;
  final double elevation;
  final FontWeight fontWeight;
  const RoundButton({super.key, required this.title,this.type = RoundButtonType.bgGradient,
  this.fontSize = 16, this.elevation = 1,this.fontWeight = FontWeight.w700,required this.onPressed });

  @override
  Widget build(BuildContext context) {
return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: type == RoundButtonType.bgSGradient ? TColor.primaryG : TColor.secondaryG,
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          if (type == RoundButtonType.bgGradient || type == RoundButtonType.bgSGradient)
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: elevation,
              offset: const Offset(0, 3),
            ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 25),
          textStyle: TextStyle(fontSize: fontSize, fontWeight: fontWeight),
          backgroundColor: Colors.transparent,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        ),
        child: type == RoundButtonType.textGradient
            ? ShaderMask(
                blendMode: BlendMode.srcIn,
                shaderCallback: (bounds) => LinearGradient(
                  colors: TColor.secondaryG, // Adjust this to your gradient colors for text
                ).createShader(bounds),
                child: Text(title, style: TextStyle(color: TColor.black)),
              )
            : Text(title, style: TextStyle(color: TColor.white)),
      ),
    );
  }
}