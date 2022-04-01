import '../utils/app_routes.dart';
import '../models/category.dart';
import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  final Category category;

  const CategoryItem({Key? key, required this.category}) : super(key: key);

  void selectCategory(BuildContext context) {
    Navigator.of(context)
        .pushNamed(
      AppRoutes.CATEGORIES_MEALS,
      arguments: category,
    ).then(
      (value) {
        if (value == null) {
          print('Sem Resultado!');
        } else {
          print('O nome da refeição é $value.');
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectCategory(context),
      borderRadius: BorderRadius.circular(15),
      splashColor: Theme.of(context).colorScheme.primary,
      child: Container(
        padding: const EdgeInsets.all(15),
        child: Text(
          category.title,
          style: Theme.of(context).textTheme.headline2,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            colors: [
              category.color.withOpacity(0.5),
              category.color,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
    );
  }
}
