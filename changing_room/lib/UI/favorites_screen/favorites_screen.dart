import 'package:changing_room/Data/providers/favorites.dart';
import 'package:changing_room/UI/widgets/main_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favoritesData = Provider.of<Favorites>(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Favorites'),
        ),
        body: ListView.builder(
          itemCount: favoritesData.favorites.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(5.0),
              child: Stack(
                children: [
                  mainImage(
                    context: context,
                    widthXHeight: MediaQuery.of(context).size.width - 10,
                    selectedHat: favoritesData.favorites.elementAt(index).selectedHat,
                    selectedAccessory: favoritesData.favorites.elementAt(index).selectedAccessories,
                    selectedShirt: favoritesData.favorites.elementAt(index).selectedShirt,
                    selectedTshirt: favoritesData.favorites.elementAt(index).selectedTshirt,
                    selectedPants: favoritesData.favorites.elementAt(index).selectedPants,
                    selectedShoes: favoritesData.favorites.elementAt(index).selectedShoes,
                  ),
                  Positioned(
                    top: 20,
                    right: 20,
                    child: IconButton(
                      onPressed: () {
                        favoritesData.removeFavorite(index);
                      },
                      icon: Icon(
                        Icons.delete,
                        color: Theme.of(context).colorScheme.error,
                        size: 30,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
      ),),
    );
  }
}
