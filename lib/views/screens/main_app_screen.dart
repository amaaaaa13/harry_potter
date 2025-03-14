import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'character_list_screen.dart';
import 'spell_list_screen.dart';
import 'favorites_screen.dart';
import 'package:harry_potter/core/constants/constant_string.dart';

// 🟢 Bottom Navigation BLoC
class BottomNavBloc extends Cubit<int> {
  BottomNavBloc() : super(0);

  void updateIndex(int index) => emit(index);
}

class MainAppScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BottomNavBloc(),
      child: Scaffold(
        body: BlocBuilder<BottomNavBloc, int>(
          builder: (context, selectedIndex) {
            return IndexedStack(
              index: selectedIndex,
              children: [
                CharacterListScreen(),
                SpellListScreen(),
                FavoritesScreen(),
              ],
            );
          },
        ),
        bottomNavigationBar: BlocBuilder<BottomNavBloc, int>(
          builder: (context, selectedIndex) {
            return BottomNavigationBar(
              backgroundColor: Color(0xFF1A1A2E), // Darker Midnight Black
              selectedItemColor: Color(0xFFFFD700), 
              unselectedItemColor: Color(0xFF7F7F7F), // Dim Grey Magic
              currentIndex: selectedIndex,
              onTap: (index) =>
                  context.read<BottomNavBloc>().updateIndex(index),
              items: [
                BottomNavigationBarItem(
                  icon: _glowingIcon(Icons.person, selectedIndex == 0),
                  label: ConstantString.charactersTab,
                ),
                BottomNavigationBarItem(
                  icon: _glowingIcon(Icons.auto_fix_high, selectedIndex == 1),
                  label: ConstantString.spellsTab,
                ),
                BottomNavigationBarItem(
                  icon: _glowingIcon(Icons.favorite, selectedIndex == 2),
                  label: ConstantString.favoritesTab,
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _glowingIcon(IconData icon, bool isSelected) {
    return Icon(
      icon,
      size: 28,
      color:
          isSelected ? Color(0xFFFFD700) : Color(0xFFB0B0B0), // Brighter Grey
      shadows: [
        Shadow(
          color: isSelected
              ? Color(0xFFFFD700).withOpacity(0.8) // Gold for selected
              : Color(0xFFB0B0B0)
                  .withOpacity(0.4), // Dim grey glow for unselected
          blurRadius: isSelected
              ? 20
              : 10, // Stronger blur for selected, subtle for unselected
        ),
        Shadow(
          color: isSelected
              ? Color(0xFFFFD700).withOpacity(0.5) // Softer gold glow
              : Color(0xFFB0B0B0).withOpacity(0.3), // Even softer grey glow
          blurRadius: isSelected ? 30 : 15,
        ),
      ],
    );
  }
}
