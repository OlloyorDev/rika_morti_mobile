import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rika_morti_mobile/core/statuses/statuses.dart';
import 'package:rika_morti_mobile/core/streams/favorite_stream_manager.dart';
import 'package:rika_morti_mobile/features/home/presentation/bloc/home_bloc.dart';
import 'package:rika_morti_mobile/features/home/presentation/widgets/character_tile.dart';
import 'package:rika_morti_mobile/features/injection_container.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        context.read<HomeBloc>().add(GetCharactersEvent(fromPagination: true));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<HomeBloc>();
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) => Scaffold(
        body: RefreshIndicator(
          onRefresh: () async => bloc.add(GetCharactersEvent()),
          child: CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverAppBar(
                title: const Text('Rika Morti'),
                floating: true,
                snap: true,
                pinned: true,
                surfaceTintColor: Colors.white,
              ),
              if (state.getStatus.failure)
                SliverFillRemaining(
                  child: Center(
                    child: Text('Something went wrong. Please try again.}'),
                  ),
                ),
              state.getStatus.loading
                  ? SliverFillRemaining(
                      child: Center(
                        child: CircularProgressIndicator.adaptive(),
                      ),
                    )
                  : SliverPadding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                          childCount: (state.characters?.list ?? []).length,
                          (context, index) {
                            final item = state.characters!.list[index];
                            return CharacterTile(
                              item: item,
                              isFavoriteAdded: state.favorites.any(
                                (e) => item.id == e.id,
                              ),
                              onTap: () =>
                                  sl<FavoriteStreamManager>()
                                    ..addFavorite(item),
                            );
                          },
                        ),
                      ),
                    ),
              !state.paginationEnd
                  ? SliverToBoxAdapter(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: CircularProgressIndicator.adaptive(),
                        ),
                      ),
                    )
                  : const SliverToBoxAdapter(child: SizedBox()),
            ],
          ),
        ),
      ),
    );
  }
}
