import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:harry_potter/core/constants/constant_string.dart';
import 'package:harry_potter/viewmodels/home_screen_bloc.dart';
import 'package:harry_potter/views/screens/main_app_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeScreenBloc()..add(StartFadeInAnimation()),
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

            // Fade-in animated content using BLoC
            BlocBuilder<HomeScreenBloc, double>(
              builder: (context, fadeInValue) {
                return AnimatedOpacity(
                  opacity: fadeInValue,
                  duration: const Duration(seconds: 2),
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
                        duration: const Duration(seconds: 2),
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
                                context
                                    .read<HomeScreenBloc>()
                                    .add(StartAnimation());
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
