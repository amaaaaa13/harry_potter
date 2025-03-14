import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:harry_potter/viewmodels/character/character_bloc.dart';
import 'package:harry_potter/viewmodels/character/character_event.dart';
import 'package:harry_potter/viewmodels/favorite/favorite_bloc.dart';
import 'package:harry_potter/viewmodels/house/house_bloc.dart';
import 'package:harry_potter/viewmodels/spell/spell_bloc.dart';
import 'package:harry_potter/viewmodels/spell/spell_event.dart';
import 'package:harry_potter/views/screens/home_screen.dart';
import 'package:harry_potter/views/screens/character_detail_screen.dart';
import 'package:harry_potter/views/screens/spell_list_screen.dart';
import 'package:harry_potter/views/screens/favorites_screen.dart'; 
import 'package:harry_potter/core/services/harry_potter_service.dart';
import 'package:harry_potter/core/constants/constant_string.dart';

void main() {
  final hpService = HarryPotterService();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_) => CharacterBloc(hpService)..add(FetchAllCharacters())),
        BlocProvider(create: (_) => HouseBloc(hpService)),
        BlocProvider(create: (_) => SpellBloc(hpService)..add(FetchSpells())),
        BlocProvider(create: (_) => FavoriteBloc()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: ConstantString.appName,
      theme: ThemeData.dark(),
      initialRoute: ConstantString.navigationIndex,
      routes: {
        ConstantString.navigationIndex: (context) =>
            HomeScreen(),
        ConstantString.navigationCharacterDetail: (context) =>
            CharacterDetailScreen(),
        ConstantString.navigationSpellList: (context) => SpellListScreen(),
        ConstantString.navigationFavorites: (context) => FavoritesScreen(),
      },
    );
  }
}
