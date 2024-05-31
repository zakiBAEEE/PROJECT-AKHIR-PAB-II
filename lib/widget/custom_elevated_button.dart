import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:red_wine/models/color_pallete.dart';

class CustomElevatedButton extends StatelessWidget {
  final Color color;
  final Color textColor;
  final double width;
  final double? height;
  final double? fontSize;
  final FontWeight fontWeight;
  final void Function()? onPressed;
  final String text;

  const CustomElevatedButton({
    super.key,
    this.color = ol10Magenta,
    this.textColor = Colors.white,
    this.width = double.infinity,
    this.height,
    this.fontSize,
    this.fontWeight = FontWeight.w600,
    this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(color),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)))),
        child: Text(
          text,
          style: GoogleFonts.montserrat(
            color: textColor,
            fontSize: fontSize,
            fontWeight: fontWeight,
          ),
        ),
      ),
    );
  }
}
