import 'package:clearcuts/Utils/videocarousel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  List<String> imagesUrl = [

  ];

  HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
          body: HomeScreenBody()
    );
  }
}

class HomeScreenBody extends StatelessWidget {
  const HomeScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    final double totalHeight = MediaQuery.of(context).size.height;
    final double column1Height = totalHeight * 0.7; // 70% of the screen height
    final double column2Height = totalHeight * 0.4; // 40% of the screen height

    return Container(
      color: Colors.white,
      child: Stack(
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
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 48,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                  ),
                  VideoCarouselWidget(
                    left: 20,
                    top: 130,
                    width: 350,
                    height: 200,
                  ),
                  Positioned(
                    bottom: 170,
                    left: 20,
                    child: Text(
                      'Make your life',
                      overflow: TextOverflow.fade,
                      textWidthBasis: TextWidthBasis.longestLine,
                      style: GoogleFonts.antonio(
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.w300,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 135,
                    left: 20,
                    child: Text(
                      'more clear',
                      overflow: TextOverflow.fade,
                      textWidthBasis: TextWidthBasis.longestLine,
                      style: GoogleFonts.antonio(
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.w300,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 100,
                    left: 20,
                    child: Text(
                      'without Backgrounds',
                      overflow: TextOverflow.fade,
                      textWidthBasis: TextWidthBasis.longestLine,
                      style: GoogleFonts.antonio(
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.w300,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: column1Height - 45.0, // Adjust this based on the radius
            child: ClipPath(
              clipper: RoundedTopClipper(),
              child: Container(
                height: 300, // Adjusted height to fit two rows of buttons
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton.icon(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.grey,
                        padding: EdgeInsets.symmetric(horizontal: 120, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {Navigator.pushNamed(context, '/upload');},
                      icon: Icon(Icons.upload_file, color: Colors.white, size: 32),
                      label: Text(
                        'Upload',
                        style: GoogleFonts.antonio(
                          textStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.w300,
                            letterSpacing: 0.3,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton.icon(
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.grey,
                            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () {},
                          icon: const Icon(Icons.photo_library, color: Colors.white, size: 24),
                          label: Text(
                            'Gallery',
                            style: GoogleFonts.antonio(
                              textStyle: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w300,
                                letterSpacing: 0.3,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        TextButton.icon(
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.grey,
                            padding: const EdgeInsets.symmetric(horizontal: 54, vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () {},
                          icon: const Icon(Icons.note, color: Colors.white, size: 24),
                          label: Text(
                            'Faq',
                            style: GoogleFonts.antonio(
                              textStyle: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w300,
                                letterSpacing: 0.3,
                              ),
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
        ],
      ),
    );
  }
}
class RoundedTopClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final double radius = 50.0;
    final Path path = Path()
      ..moveTo(0, radius)
      ..quadraticBezierTo(0, 0, radius, 0)
      ..lineTo(size.width - radius, 0)
      ..quadraticBezierTo(size.width, 0, size.width, radius)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}