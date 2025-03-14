import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:harry_potter/viewmodels/spell/spell_bloc.dart';
import 'package:harry_potter/viewmodels/spell/spell_state.dart';
import 'package:harry_potter/viewmodels/favorite/favorite_bloc.dart';
import 'package:harry_potter/core/constants/constant_string.dart';

class SpellListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF1A1A2E),
        elevation: 4,
        centerTitle: true,
        title: Text(
          ConstantString.spells,
          style: TextStyle(
            fontFamily: ConstantString.fontHarryP,
            fontSize: 32,
            color: Colors.amber,
          ),
        ),
      ),
      body: BlocBuilder<SpellBloc, SpellState>(
        builder: (context, state) {
          if (state is SpellLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is SpellError) {
            return Center(child: Text(ConstantString.tryAgainLater));
          } else if (state is SpellLoaded) {
            if (state.spells.isEmpty) {
              return Center(child: Text(ConstantString.noSpellsFound));
            }
            return ListView.builder(
              itemCount: state.spells.length,
              itemBuilder: (context, index) {
                final spell = state.spells[index];

                return BlocBuilder<FavoriteBloc, FavoriteState>(
                  builder: (context, favoriteState) {
                    final isFavorite =
                        favoriteState.favoriteSpells.contains(spell);

                    return GestureDetector(
                      child: Card(
                        elevation: 5,
                        margin:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          contentPadding: EdgeInsets.all(12),
                          title: Text(
                            spell.name,
                            style: TextStyle(
                              fontFamily: ConstantString.fontCinzel,
                              fontSize: 20,
                              color: Colors.amber, 
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            spell.description,
                            style: TextStyle(
                              fontFamily: ConstantString.fontGaramond,
                              fontSize: 16,
                              color: Colors.white70, 
                            ),
                          ),
                          trailing: IconButton(
                            icon: Icon(
                              isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: isFavorite ? Colors.red : Colors.grey,
                            ),
                            onPressed: () {
                              context
                                  .read<FavoriteBloc>()
                                  .add(ToggleFavoriteSpell(spell));
                            },
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            );
          }
          return Center(child: Text(ConstantString.tryAgainLater));
        },
      ),
    );
  }
}
