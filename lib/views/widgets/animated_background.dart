import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:harry_potter/viewmodels/gradient/gradient_bloc.dart';
import 'package:harry_potter/viewmodels/gradient/gradient_event.dart';
import 'package:harry_potter/viewmodels/gradient/gradient_state.dart';

class AnimatedBackground extends StatelessWidget {
  final String house;

  AnimatedBackground({required this.house});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GradientBloc()..add(StartGradientAnimation(house)),
      child: BlocBuilder<GradientBloc, GradientState>(
        builder: (context, state) {
          if (state is GradientUpdated) {
            return AnimatedContainer(
              duration: Duration(milliseconds: 1500),
              curve: Curves.easeInOut,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: state.gradientColors,
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            );
          }

          // While waiting for the first update, return an empty container
          return Container();
        },
      ),
    );
  }
}
