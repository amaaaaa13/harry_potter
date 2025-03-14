import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../viewmodels/favorite/favorite_bloc.dart';
import '../../core/constants/constant_string.dart';

class FavoritesScreen extends StatefulWidget {
  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    /// 📌 Load favorites when the screen initializes
    context.read<FavoriteBloc>().add(LoadFavorites());
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A2E),
        elevation: 4,
        centerTitle: true,
        title: const Text(
          'Favorites',
          style: TextStyle(
            fontFamily: ConstantString.fontHarryP,
            fontSize: 32,
            color: Colors.amber,
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Characters'),
            Tab(text: 'Spells'),
          ],
        ),
      ),
      body: BlocBuilder<FavoriteBloc, FavoriteState>(
        builder: (context, state) {
          return TabBarView(
            controller: _tabController,
            children: [
              _buildFavoriteList(state.favoriteCharacters, isCharacter: true),
              _buildFavoriteList(state.favoriteSpells, isCharacter: false),
            ],
          );
        },
      ),
    );
  }

  Widget _buildFavoriteList(List<dynamic> items, {required bool isCharacter}) {
    if (items.isEmpty) {
      return Center(
        child: Text(
          isCharacter
              ? 'No favorite characters yet!'
              : 'No favorite spells yet!',
          style: TextStyle(
            fontFamily: ConstantString.fontGaramond,
            fontSize: 24,
            color: Colors.grey[400],
          ),
        ),
      );
    }

    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];

        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          color: const Color(0xFF1A1A2E),
          elevation: 4,
          child: ListTile(
            contentPadding: const EdgeInsets.all(16),
            title: Text(
              item.name,
              style: const TextStyle(
                fontFamily: ConstantString.fontGaramond,
                fontSize: 22,
                color: Colors.amber,
              ),
            ),
            subtitle: Text(
              isCharacter
                  ? 'House: ${item.house}'
                  : (item.description.isNotEmpty
                      ? item.description
                      : 'No Description'),
              style: TextStyle(
                fontFamily: ConstantString.fontGaramond,
                fontSize: 16,
                color: Colors.grey[300],
              ),
            ),
            leading: const Icon(
              Icons.star,
              color: Colors.amber,
              size: 32,
            ),
            trailing: IconButton(
              icon: const Icon(
                Icons.favorite,
                color: Colors.red, // Red heart for unfavoriting
                size: 30,
              ),
              onPressed: () {
                final bloc = context.read<FavoriteBloc>();

                if (isCharacter) {
                  bloc.add(ToggleFavoriteCharacter(item));
                } else {
                  bloc.add(ToggleFavoriteSpell(item));
                }
              },
            ),
          ),
        );
      },
    );
  }
}
