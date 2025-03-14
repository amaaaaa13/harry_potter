import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:harry_potter/core/constants/constant_string.dart';
import 'package:harry_potter/views/screens/main_app_screen.dart';
import 'package:harry_potter/viewmodels/home_screen_cubit.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeInAnimation;

  @override
  void initState() {
    super.initState();

    // Set up the fade-in animation for cinematic entry
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    _fadeInAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    // Start the animation
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeScreenCubit(),
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            // Background Image
            Image.asset(
              'assets/images/hogwarts_bg.jpg',
              fit: BoxFit.cover,
            ),

            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.2),
                    Colors.black.withOpacity(0.7),
                  ],
                ),
              ),
            ),

            // Fade-in animated content using the BLoC value
            BlocBuilder<HomeScreenCubit, double>(
              builder: (context, fadeInValue) {
                return FadeTransition(
                  opacity: _fadeInAnimation, // Fade transition for text
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // "Harry Potter" Title
                      Text(
                        ConstantString.appName,
                        style: TextStyle(
                          fontFamily: ConstantString.fontHarryP,
                          fontSize: 100,
                          color: Colors.amber,
                          letterSpacing: 2,
                          shadows: [
                            Shadow(
                              blurRadius: 15,
                              color: Colors.black87,
                              offset: Offset(4, 4),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 30),

                      // Magical Glowing Entry Button
                      TweenAnimationBuilder<double>(
                        tween: Tween<double>(begin: 0, end: 1),
                        duration: Duration(seconds: 2),
                        builder: (context, glow, child) {
                          return Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.amber.withOpacity(glow),
                                  blurRadius: 25,
                                  spreadRadius: 4,
                                ),
                              ],
                            ),
                            child: ElevatedButton(
                              onPressed: () {
                                // Start animation and navigate to the next screen
                                context
                                    .read<HomeScreenCubit>()
                                    .startAnimation();
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MainAppScreen(),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.amber,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 50, vertical: 22),
                                textStyle: TextStyle(
                                  fontSize: 26,
                                  fontFamily: ConstantString.fontHarryP,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                elevation: 10,
                              ),
                              child: Text(
                                'Tap to Enter',
                                style: TextStyle(color: Colors.black54),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
