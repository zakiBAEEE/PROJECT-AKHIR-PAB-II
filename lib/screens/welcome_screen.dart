import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:red_wine/models/assets.dart';
import 'package:red_wine/models/color_pallete.dart';
import 'package:red_wine/widget/custom_elevated_button.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key:key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        width:double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image:DecorationImage(
            colorFilter: ColorFilter.mode(Colors.grey, BlendMode.multiply),
            image: AssetImage(Assets.bgpic),fit : BoxFit.cover)),
       child :SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal:20,vertical:40),
        child:Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Image.asset(Assets.logo,width:100),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Pempek Terbaik Ada disini",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold)),
                const SizedBox(
                  height:10,
                ),
                Text("Join 6 Mill People",
                textAlign: TextAlign.center,
                style:GoogleFonts.montserrat(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold))
              ],
            ),
            Column(
              children: [
                CustomElevatedButton(
                  text: 'Login',
                  height:45,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  onPressed: () {},
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Dont Have An Account?",
                        style:GoogleFonts.montserrat(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        )),
                      const SizedBox(
                        width: 10,
                      ),
                      const CustomElevatedButton(
                        text:'Sign Up',
                        width:120,
                        color:Colors.white,
                        textColor: ol10Magenta, 
                      )
                  ],)
              ],
            )
          ],
        )
       )),
      )
    );
  }
}