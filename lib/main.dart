import '../screens/settings_screen.dart';
import '../screens/tabs_screen.dart';
import 'package:flutter/material.dart';
import 'screens/categories_meals_screen.dart';
import 'screens/meal_detail_screen.dart';
import 'utils/app_routes.dart';
import 'models/meal.dart';
import 'data/dummy_data.dart';
import 'models/settings.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Settings settings = Settings();
  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favoriteMeals = [];

  void _filterMeals(Settings settings) {
    setState(() {
      this.settings = settings;
      _availableMeals = DUMMY_MEALS.where((meal) {
        final fGluten = settings.isGlutenFree && !meal.isGlutenFree;
        final fLactose = settings.isLactoseFree && !meal.isLactoseFree;
        final fVegan = settings.isVegan && !meal.isVegan;
        final fVegetarian = settings.isVegetarian && !meal.isVegetarian;
        return !fGluten && !fLactose && !fVegan && !fVegetarian;
      }).toList();
    });
  }

  void _onToggleFavorite(Meal meal) {
    setState(() {
      _favoriteMeals.contains(meal) ? _favoriteMeals.remove(meal) : _favoriteMeals.add(meal);
    });
  }

  bool _isFavorite(Meal meal) {
    return _favoriteMeals.contains(meal);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = ThemeData();
    return MaterialApp(
      title: 'DeliMeals',
      theme: themeData.copyWith(
        colorScheme: themeData.colorScheme.copyWith(
          primary: Colors.pink,
          secondary: Colors.amber,
        ),
        canvasColor: const Color.fromRGBO(255, 254, 229, 1),
        textTheme: ThemeData.light().textTheme.copyWith(
              headline1: const TextStyle(
                fontFamily: 'Raleway',
              ),
              headline2: const TextStyle(
                fontFamily: 'RobotoCondensed',
                fontSize: 20,
                color: Colors.black,
              ),
            ),
      ),
      routes: {
        AppRoutes.HOME: (ctx) => TabsScreen(favoriteMeals: _favoriteMeals),
        AppRoutes.CATEGORIES_MEALS: (ctx) =>
            CategoriesMealsScreen(meals: _availableMeals),
        AppRoutes.MEAL_DETAIL: (ctx) => MealDetailScreen(onToggleFavorite: _onToggleFavorite, isFavorite: _isFavorite,),
        AppRoutes.SETTINGS: (ctx) =>
            SettingsScreen(settings: settings, onSettingsChanged: _filterMeals),
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (_) {
            return TabsScreen(favoriteMeals: _favoriteMeals);
          },
        );
      },
    );
  }
}
