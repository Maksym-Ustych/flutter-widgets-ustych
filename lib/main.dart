import 'package:flutter/material.dart';

import 'screens/home_screen.dart';
import 'screens/products_screen.dart';
import 'screens/profile_screen.dart';
import 'utils/app_state.dart';
import 'utils/themes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AppState appState = AppState();

  int currentIndex = 0;
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    final screens = [
      HomeScreen(appState: appState),
      ProductsScreen(appState: appState),
      ProfileScreen(appState: appState),
    ];

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Widgets App',
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: Scaffold(
        body: screens[currentIndex],
        bottomNavigationBar: NavigationBar(
          selectedIndex: currentIndex,
          onDestinationSelected: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home),
              label: 'Головна',
            ),
            NavigationDestination(
              icon: Icon(Icons.shopping_bag_outlined),
              selectedIcon: Icon(Icons.shopping_bag),
              label: 'Товари',
            ),
            NavigationDestination(
              icon: Icon(Icons.person_outline),
              selectedIcon: Icon(Icons.person),
              label: 'Профіль',
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              isDarkMode = !isDarkMode;
            });
          },
          child: Icon(
            isDarkMode ? Icons.light_mode : Icons.dark_mode,
          ),
        ),
      ),
    );
  }
}