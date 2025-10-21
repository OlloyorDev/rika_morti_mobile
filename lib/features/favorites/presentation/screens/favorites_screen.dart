import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rika_morti_mobile/core/streams/favorite_stream_manager.dart';
import 'package:rika_morti_mobile/features/favorites/presentation/bloc/favorites_bloc.dart';
import 'package:rika_morti_mobile/features/home/presentation/widgets/character_tile.dart';
import 'package:rika_morti_mobile/features/injection_container.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) =>
      BlocBuilder<FavoritesBloc, FavoritesState>(
        builder: (context, state) => Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                title: const Text('Favorites'),
                floating: true,
                snap: true,
                pinned: true,
                surfaceTintColor: Colors.white,
              ),
              state.favorites.isEmpty
                  ? SliverFillRemaining(
                      child: Center(
                        child: Text(
                          'No favorites added yet.',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    )
                  : SliverPadding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                          childCount: state.favorites.length,
                          (context, index) {
                            final item = state.favorites[index];
                            return CharacterTile(
                              item: item,
                              isFavoriteAdded: true,
                              onTap: () =>
                                  sl<FavoriteStreamManager>()
                                    ..addFavorite(item),
                            );
                          },
                        ),
                      ),
                    ),
            ],
          ),
        ),
      );
}
