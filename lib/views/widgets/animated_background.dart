import 'package:flutter/material.dart';
import 'package:harry_potter/viewmodels/gradient/gradient_bloc.dart';

class AnimatedBackground extends StatefulWidget {
  final String house;

  AnimatedBackground({required this.house});

  @override
  _AnimatedBackgroundState createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground> {
  late GradientBloc _gradientBloc;
  late List<Color> _initialGradient;

  @override
  void initState() {
    super.initState();
    _gradientBloc = GradientBloc(widget.house);
    _initialGradient = _gradientBloc.gradientColors[0];
  }

  @override
  void dispose() {
    _gradientBloc.dispose(); // Dispose the BLoC
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Color>>(
      stream: _gradientBloc
          .gradientStream, // Listen to the BLoC stream for gradient updates
      builder: (context, snapshot) {
        // If gradient data is available, use it, otherwise fall back to the initial gradient
        List<Color> gradientColors =
            snapshot.hasData ? snapshot.data! : _initialGradient;

        return AnimatedContainer(
          duration: Duration(milliseconds: 1500), // Smooth animation duration
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: gradientColors,
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        );
      },
    );
  }
}
