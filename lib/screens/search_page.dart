import 'package:ecommerce_app/utils/utils.dart';
import 'package:flutter/material.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: const EdgeInsets.all(10),
                child: Hero(
                  tag: 'search-bar',
                  child: SearchBar(
                    hintText: 'Search for products',
                    trailing: [
                      IconButton(
                        icon: const Icon(Icons.search_rounded),
                        onPressed: () {
                          showMsg(context, 'In dev.');
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
