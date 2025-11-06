import 'package:flutter/material.dart';

class DishCard extends StatelessWidget {
  const DishCard({super.key, required this.dish});

  final Dish dish;

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      child: Material(
        elevation: 1,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
              child: Image.asset(
                dish.image,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      dish.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(dish.description),
                    const SizedBox(height: 5),
                    Text(
                      dish.price,
                      style: const TextStyle(
                        color: Colors.teal,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );;
  }
}


class Dish {
  final String name;
  final String description;
  final String price;
  final String image;

  Dish({
    required this.name,
    required this.description,
    required this.price,
    required this.image,
  });

  factory Dish.fromMap(Map<String, String> map) {
    return Dish(
      name: map['name']!,
      description: map['description']!,
      price: map['price']!,
      image: map['image']!,
    );
  }
}
