import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:harry_potter/models/character.dart';
import 'package:harry_potter/viewmodels/character/character_bloc.dart';
import 'package:harry_potter/viewmodels/character/character_state.dart';
import 'package:harry_potter/views/widgets/detail_row.dart';
import 'package:harry_potter/views/widgets/animated_background.dart';

class CharacterDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final character = ModalRoute.of(context)?.settings.arguments as Character?;

    if (character == null) {
      // If the character is null, navigate back
      Future.delayed(Duration(milliseconds: 100), () {
        Navigator.of(context).popUntil((route) => route.isFirst);
      });

      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    // Optionally, trigger a BLoC event if more data needs to be fetched
    // For example, we might dispatch an event here to fetch additional character details.
    // character can be passed to fetch more specific data.

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          character.name,
          style: TextStyle(fontFamily: 'HarryP', fontSize: 24),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          // Animated background widget based on the character's house
          AnimatedBackground(house: character.house),

          // House logo in the background (only if the house is known)
          if (character.house.isNotEmpty)
            Positioned.fill(
              child: Opacity(
                opacity: 0.15,
                child: Image.asset(
                  'assets/images/${character.house.toLowerCase()}.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),

          // Main content (Character details)
          BlocBuilder<CharacterBloc, CharacterState>(builder: (context, state) {
            // Show loading state if character data is being fetched
            if (state is CharacterLoading) {
              return Center(child: CircularProgressIndicator());
            }

            // Show error state if there's an issue fetching character data
            if (state is CharacterError) {
              return Center(child: Text(state.message));
            }

            return CustomScrollView(
              physics: BouncingScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 80),

                        // Character Image with Hero transition
                        Hero(
                          tag: character.image,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: FadeInImage.assetNetwork(
                              placeholder:
                                  'assets/images/default_character.jpeg',
                              image: character.image,
                              width: 250,
                              height: 250,
                              fit: BoxFit.cover,
                              imageErrorBuilder: (context, error, stackTrace) =>
                                  Image.asset(
                                'assets/images/default_character.jpeg',
                                width: 250,
                                height: 250,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 20),

                        // Character Name
                        Text(
                          character.name,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Cinzel',
                            color: Colors.white,
                            shadows: [
                              Shadow(
                                blurRadius: 10,
                                color: Colors.black,
                                offset: Offset(2, 2),
                              )
                            ],
                          ),
                        ),

                        SizedBox(height: 20),

                        // Glassmorphism styled detail card
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                                color: Colors.white.withOpacity(0.2)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 10,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              DetailRow(title: "Actor", value: character.actor),
                              DetailRow(
                                  title: "House",
                                  value: character.house.isNotEmpty
                                      ? character.house
                                      : "No House"),
                              DetailRow(
                                  title: "Wand",
                                  value: character.wand?.wood ?? "Unknown"),
                              DetailRow(
                                  title: "Core",
                                  value: character.wand?.core ?? "Unknown"),
                              DetailRow(
                                  title: "Length",
                                  value: character.wand?.length?.toString() ??
                                      "Unknown"),
                              DetailRow(
                                  title: "Patronus",
                                  value: character.patronus.isNotEmpty
                                      ? character.patronus
                                      : "Unknown"),
                              DetailRow(
                                  title: "Species", value: character.species),
                              DetailRow(
                                  title: "Blood Status",
                                  value: character.ancestry.isNotEmpty
                                      ? character.ancestry
                                      : "Unknown"),
                              DetailRow(
                                  title: "Eye Color",
                                  value: character.eyeColour.isNotEmpty
                                      ? character.eyeColour
                                      : "Unknown"),
                              DetailRow(
                                  title: "Hair Color",
                                  value: character.hairColour.isNotEmpty
                                      ? character.hairColour
                                      : "Unknown"),
                              DetailRow(
                                  title: "Date of Birth",
                                  value:
                                      character.dateOfBirth?.isNotEmpty == true
                                          ? character.dateOfBirth!
                                          : "Unknown"),
                              DetailRow(
                                  title: "Year of Birth",
                                  value: character.yearOfBirth != null
                                      ? character.yearOfBirth.toString()
                                      : "Unknown"),
                              DetailRow(
                                  title: "Alive",
                                  value: character.alive ? "Yes" : "No"),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }),
        ],
      ),
    );
  }
}
