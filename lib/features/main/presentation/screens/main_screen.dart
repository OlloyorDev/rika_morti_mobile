import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rika_morti_mobile/features/favorites/presentation/screens/favorites_screen.dart';
import 'package:rika_morti_mobile/features/home/presentation/screens/home_screen.dart';
import 'package:rika_morti_mobile/features/main/presentation/bloc/main_bloc.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<MainBloc>();
    return BlocBuilder<MainBloc, MainState>(
      builder: (context, state) {
        return Scaffold(
          body: IndexedStack(
            index: state.currentScreen.index,
            children: [
              HomeScreen(),
              FavoritesScreen(),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            selectedFontSize: 18,
            unselectedFontSize: 18,
            currentIndex: state.currentScreen.index,
            onTap: (index) {
              final selectedScreen = MainScreens.values[index];
              bloc.add(MainScreenChange(selectedScreen));
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.view_list),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: 'Favorites',
              ),
            ],
          ),
        );
      },
    );
  }
}
