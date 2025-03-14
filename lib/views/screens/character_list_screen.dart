import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:harry_potter/viewmodels/character/character_bloc.dart';
import 'package:harry_potter/viewmodels/character/character_event.dart';
import 'package:harry_potter/viewmodels/character/character_state.dart';
import 'package:harry_potter/viewmodels/favorite/favorite_bloc.dart';
import 'package:harry_potter/models/character.dart';
import 'package:harry_potter/views/widgets/house_filter_widget.dart';
import 'dart:async';

class CharacterListScreen extends StatefulWidget {
  const CharacterListScreen({super.key});

  @override
  State<CharacterListScreen> createState() => _CharacterListScreenState();
}

class _CharacterListScreenState extends State<CharacterListScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  late TabController _tabController;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _fetchDataForTab(0); // Initially fetch all characters
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) return;
      _fetchDataForTab(_tabController.index);
      _searchController.clear();
    });
  }

  void _fetchDataForTab(int index) {
    switch (index) {
      case 0:
        BlocProvider.of<CharacterBloc>(context).add(const FetchAllCharacters());
        break;
      case 1:
        BlocProvider.of<CharacterBloc>(context).add(const FetchStudents());
        break;
      case 2:
        BlocProvider.of<CharacterBloc>(context).add(const FetchStaff());
        break;
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    _tabController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _handleSearch(String query) {
    // Cancel the previous debounce and start a new one
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      BlocProvider.of<CharacterBloc>(context).add(SearchCharacter(query));
    });
  }

  void _handleHouseChange(String? house) {
    BlocProvider.of<CharacterBloc>(context).add(SelectHouse(house ?? 'All'));
    _searchController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D0D), // Dark magical background

      appBar: AppBar(
        title: const Text(
          'Hogwarts Characters',
          style: TextStyle(
            fontFamily: 'HarryP',
            fontSize: 32,
            color: Color(0xFFFFD700),
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF1A1A2E), // Midnight blue theme
        elevation: 5,
        shadowColor: Colors.black.withOpacity(0.5),

        bottom: TabBar(
          controller: _tabController,
          labelColor: const Color(0xFFFFD700),
          unselectedLabelColor: Colors.white70,
          indicatorColor: const Color(0xFFFFD700),
          tabs: const [
            Tab(text: 'All'),
            Tab(text: 'Students'),
            Tab(text: 'Staff'),
          ],
        ),
      ),

      body: Column(
        children: [
          // 🔍 Search Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              controller: _searchController,
              onChanged: _handleSearch,
              style: TextStyle(
                color: _searchController.text.isEmpty
                    ? Colors.white
                    : const Color(0xFFFFD700),
                fontSize: 18,
                fontFamily: 'Garamond',
              ),
              decoration: InputDecoration(
                hintText: 'Search for a character...',
                hintStyle: const TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                  fontFamily: 'Garamond',
                ),
                prefixIcon: const Icon(Icons.search,
                    color: Color(0xFFC0C0C0)), 

                filled: true,
                fillColor: Colors.black.withOpacity(0.2), 
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12), // Smooth edges
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          // 🏠 House Filter Dropdown
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: BlocBuilder<CharacterBloc, CharacterState>(
              builder: (context, state) {
                String selectedHouse = 'All';
                if (state is CharacterLoaded) {
                  selectedHouse = state.selectedHouse;
                }
                return HouseFilter(
                  houses: const [
                    'All',
                    'Gryffindor',
                    'Slytherin',
                    'Ravenclaw',
                    'Hufflepuff',
                    'Unknown'
                  ],
                  selectedHouse: selectedHouse,
                  onChanged: _handleHouseChange,
                );
              },
            ),
          ),

          // 📜 Character List
          Expanded(
            child: BlocBuilder<CharacterBloc, CharacterState>(
              builder: (context, state) {
                if (state is CharacterLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is CharacterError) {
                  return Center(
                    child: Text(
                      "Error: ${state.message}",
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                } else if (state is CharacterLoaded) {
                  return _buildCharacterGrid(state.characters);
                }
                return const Center(child: Text('Unexpected state!'));
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCharacterGrid(List<Character> characters) {
    if (characters.isEmpty) {
      return const Center(
        child: Text(
          'No characters found!',
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      );
    }

    return BlocBuilder<FavoriteBloc, FavoriteState>(
      builder: (context, favoriteState) {
        return GridView.builder(
          padding: const EdgeInsets.all(8),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount:
                (MediaQuery.of(context).size.width ~/ 180).clamp(2, 4),
            childAspectRatio: 0.7,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemCount: characters.length,
          itemBuilder: (context, index) {
            final character = characters[index];
            final isFavorite =
                favoriteState.favoriteCharacters.contains(character);

            return GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/characterDetail',
                    arguments: character);
              },
              child: Card(
                color: const Color(0xFF222831), // Dark parchment look
                elevation: 4,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(10)),
                        child: Image.network(
                          character.image.isNotEmpty
                              ? character.image
                              : 'assets/images/default_character.jpeg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  character.name,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  character.house.isNotEmpty
                                      ? character.house
                                      : 'No House',
                                  style: const TextStyle(
                                      fontSize: 12, color: Colors.white70),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: isFavorite ? Colors.red : Colors.grey,
                            ),
                            onPressed: () {
                              BlocProvider.of<FavoriteBloc>(context)
                                  .add(ToggleFavoriteCharacter(character));
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
