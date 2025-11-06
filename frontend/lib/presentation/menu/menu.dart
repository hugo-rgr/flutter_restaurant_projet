import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_restaurant_app/presentation/menu/state/menu_notifier.dart';
import 'package:flutter_restaurant_app/presentation/menu/state/menu_state.dart';
import 'package:flutter_restaurant_app/presentation/menu/widgets/dish_card.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../common/base_page.dart';

class Menu extends BasePage<MenuNotifier, MenuState> {
  Menu({super.key}) : super(provider: menuNotifierProvider);

  static const route = '/menu';

  @override
  Widget buildContent(BuildContext context, WidgetRef ref, MenuState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        SizedBox(
          height: 60,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: ref.read(notifier).categories.length,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            itemBuilder: (context, index) {
              final category = ref.read(notifier).categories[index];
              final isSelected =
                  category == ref.read(notifier).selectedCategory;
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 10,
                ),
                child: GestureDetector(
                  onTap: () {

                    ref.read(notifier).selectCategory(category);
                    /* setState(() {
                      selectedCategory = category;
                    });*/
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.teal : Colors.grey[300],
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: Center(
                      child: Text(
                        category,
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black87,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: ListView.builder(
            itemCount:
                ref
                    .read(notifier)
                    .menu[ref.read(notifier).selectedCategory]!
                    .length,
            itemBuilder: (context, index) {
              final dish =
                  ref.read(notifier).menu[ref
                      .read(notifier)
                      .selectedCategory]![index];
              return DishCard(dish: Dish.fromMap(dish));
            },
          ),
        ),
      ],
    );
  }

  @override
  AppBar? buildAppBar(BuildContext context, WidgetRef ref, MenuState? state) {
    return AppBar(
      backgroundColor: Colors.orange,
      title: Text(
        'RESTAU CHEZ O’REILLY',
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
    );
  }

  @override
  Color? buildBackgroundColor(WidgetRef ref, MenuState? state) {
    return Colors.white;
  }
}
