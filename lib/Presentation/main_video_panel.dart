import 'package:clearcuts/Presentation/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MainVideoPanel extends StatelessWidget {
  const MainVideoPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final double totalHeight = MediaQuery.of(context).size.height;
    final double column1Height = totalHeight * 0.9; // 70% of the screen height
    final double column2Height = totalHeight * 0.1; // 40% of the screen height

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            child: SizedBox(
              height: column1Height,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    'assets/images/homeScreenBG.png', // Replace with your image path
                    fit: BoxFit.cover,
                  ),
                  Container(color: Colors.black.withOpacity(0.1)),
                  Positioned(
                    top: 40,
                    left: 20,
                    child: Text(
                      'CLEAR CUTS',
                      style: GoogleFonts.anton(
                        textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 48,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 130,
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Container(
                height: 220,
                width: MediaQuery.of(context).size.width - 40,
                color: Colors.grey,
              ),
            )
          ),
          Positioned(
              top: 380,
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Container(
                  height: 220,
                  width: MediaQuery.of(context).size.width - 40,
                  color: Colors.grey,
                ),
              )
          ),
          Positioned(
            top: column1Height - 45.0, // Adjust this based on the radius
            child: ClipPath(
              clipper: RoundedTopClipper(),
              child: Container(
                height: 300, // Adjusted height to fit two rows of buttons
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
