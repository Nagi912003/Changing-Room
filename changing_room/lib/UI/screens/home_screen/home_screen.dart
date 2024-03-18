import 'package:changing_room/UI/screens/add_clothes_screen/AddClothesScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:changing_room/Data/models/piece.dart';

import '../../../Data/providers/clothes.dart';
import '../../../Data/providers/favorites.dart';
import '../../../Data/providers/clothes_filter.dart';
import '../../../Data/providers/clothes_selector_provider.dart';

import '../../favorites_screen/favorites_screen.dart';

import '../../widgets/main_image_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool showSettings = false;

  @override
  Widget build(BuildContext context) {
    final clothesData = Provider.of<Clothes>(context);
    final selectorData = Provider.of<ClothesSelectorProvider>(context);
    final selectedTshirt = selectorData.selectedTshirt;
    final selectedPants = selectorData.selectedPants;
    final selectedShoes = selectorData.selectedShoes;
    final selectedHat = selectorData.selectedHat;
    final selectedAccessory = selectorData.selectedAccessories;
    final selectedShirt = selectorData.selectedShirt;

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            // title
            const Positioned(
              top: 10,
              left: 70,
              child: Text('My cupboard', style: TextStyle(fontSize: 28)),
            ),
            // main image
            Align(
              alignment: const Alignment(0, -0.7),
              child: SizedBox(
                height: MediaQuery.sizeOf(context).width,
                child: Stack(
                  children: [
                    mainImage(
                        context: context,
                        widthXHeight: MediaQuery.sizeOf(context).width,
                        selectedAccessory: selectedAccessory,
                        selectedHat: selectedHat,
                        selectedPants: selectedPants,
                        selectedShirt: selectedShirt,
                        selectedShoes: selectedShoes,
                        selectedTshirt: selectedTshirt),

                    //add to favorites button
                    Align(
                      alignment: const Alignment(0.9, -0.9),
                      child: IconButton(
                        icon: Icon(
                          Icons.add_circle_outline,
                          color: Theme.of(context).primaryColorLight,
                          size: 40,
                        ),
                        onPressed: () {
                          FavoriteItem favoriteItem = FavoriteItem(
                            selectedHat: selectedHat,
                            selectedAccessories: selectedAccessory,
                            selectedShirt: selectedShirt,
                            selectedTshirt: selectedTshirt,
                            selectedPants: selectedPants,
                            selectedShoes: selectedShoes,
                          );
                          // Provider.of<Favorites>(context, listen: false)
                          //     .addFavorite(favoriteItem);
                          if (Provider.of<Favorites>(context, listen: false)
                              .addFavorite(favoriteItem)) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor:
                                    Theme.of(context).colorScheme.secondary,
                                content: const Text('Added to favorites'),
                                duration: const Duration(seconds: 1),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor:
                                    Theme.of(context).colorScheme.error,
                                content: const Text('Please select all items'),
                                duration: const Duration(seconds: 1),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // clothes column list
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: clothsColumn(context,
                  hats: clothesData.hats,
                  accessories: clothesData.accessories,
                  shirts: clothesData.shirts,
                  tShirts: clothesData.tshirts,
                  pants: clothesData.pants,
                  shoes: clothesData.shoes),
            ),
            // settings list bottom inkwell
            if (showSettings)
              InkWell(
                onTap: () => setState(() => showSettings = false),
                child: Container(
                  color: Colors.black.withOpacity(0.5),
                  height: MediaQuery.sizeOf(context).height,
                  width: MediaQuery.sizeOf(context).width,
                ),
              ),
            // settings button
            Positioned(
              top: 0,
              left: 0,
              child: IconButton(
                icon: const Icon(
                  Icons.settings,
                  size: 40,
                ),
                onPressed: () => setState(() => showSettings = !showSettings),
              ),
            ),
            // reset button
            Positioned(
              top: 0,
              right: 0,
              child: IconButton(
                icon: const Icon(
                  Icons.restart_alt,
                  size: 40,
                ),
                onPressed: () => setState(() => selectorData.deselectAll()),
              ),
            ),
            // open favorites button
            Positioned(
              top: 0,
              right: 70,
              child: IconButton(
                icon: const Icon(
                  Icons.favorite,
                  size: 40,
                ),
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const FavoritesScreen())),
              ),
            ),
            // settings list
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: topSettingsList(context, showSettings),
            ),
          ],
        ),
      ),
    );
  }

  Widget clothsColumn(
    context, {
    List<Piece> hats = const [],
    List<Piece> accessories = const [],
    List<Piece> shirts = const [],
    List<Piece> tShirts = const [],
    List<Piece> pants = const [],
    List<Piece> shoes = const [],
  }) {
    return SizedBox(
      height: 400,
      child: SingleChildScrollView(
        child: Row(
          children: [
            Container(
              width: 100,
              height: 400,
              // color: Theme.of(context).cardColor,
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => const AddClothesScreen()),
                  );
                },
                child: Card(
                  child: Center(
                    child: Icon(
                      Icons.add,
                      color: Theme.of(context).primaryColorLight,
                      size: 40,
                    ),
                  ),
                ),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(width: MediaQuery.sizeOf(context).width - 100),
                // hats & accessories list
                if (hats.isNotEmpty || accessories.isNotEmpty)
                  choicesList(context, [...hats, ...accessories]),
                // jackets and shirts list
                if (shirts.isNotEmpty) choicesList(context, shirts),
                // t-shirts list
                if (tShirts.isNotEmpty) choicesList(context, tShirts),
                // pants list
                if (pants.isNotEmpty) choicesList(context, pants),
                // shoes list
                if (shoes.isNotEmpty) choicesList(context, shoes),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget choicesList(BuildContext context, List<Piece> list) {
    final selectorData = Provider.of<ClothesSelectorProvider>(context);
    return SizedBox(
      width: MediaQuery.sizeOf(context).width - 100,
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: list.length,
        itemBuilder: (context, index) => SizedBox(
          width: 100,
          child: InkWell(
            onTap: () {
              selectorData.toggleSelected(list[index]);
            },
            child: Card(
              color: selectorData.isPieceSelected(list[index])
                  ? Theme.of(context).colorScheme.onBackground.withOpacity(0.8)
                  : Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  list[index].images.first,
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget topSettingsList(context, showSettings) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      color: Theme.of(context).colorScheme.background,
      height: showSettings ? MediaQuery.sizeOf(context).height * 0.8 : 0,
      width: 100,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              //          ... Global filters ...
              _buildRadioGroup('Going out??', OutDoors.values, Filter.outDoors,
                  (value) {
                setState(() {
                  Filter.outDoors = value!;
                });
              }),
              _buildRadioGroup('Weather', ForWeather.values, Filter.forWeather,
                  (value) {
                setState(() {
                  Filter.forWeather = value!;
                });
              }),
              _buildRadioGroup(
                  'Brightness', Brightness.values, Filter.brightness, (value) {
                setState(() {
                  Filter.brightness = value!;
                });
              }),
              _buildRadioGroup('Fit', Fit.values, Filter.fit, (value) {
                setState(() {
                  Filter.fit = value!;
                });
              }),
              //                    ... New ...

              const Divider(),
              _buildNewFilterWithChoiceChip('New Shirts', Filter.newShirts,
                  (value) {
                setState(() {
                  Filter.newShirts = value;
                });
              }),

              _buildNewFilterWithChoiceChip('New T-shirts', Filter.newTshirts,
                  (value) {
                setState(() {
                  Filter.newTshirts = value;
                });
              }),

              _buildNewFilterWithChoiceChip('New Pants', Filter.newPants,
                  (value) {
                setState(() {
                  Filter.newPants = value;
                });
              }),
              _buildNewFilterWithChoiceChip('New Hats', Filter.newHats,
                  (value) {
                setState(() {
                  Filter.newHats = value;
                });
              }),
              _buildNewFilterWithChoiceChip(
                  'New Accessories', Filter.newAccessories, (value) {
                setState(() {
                  Filter.newAccessories = value;
                });
              }),
              _buildNewFilterWithChoiceChip('New Shoes', Filter.newShoes,
                  (value) {
                setState(() {
                  Filter.newShoes = value;
                });
              }),

              //                 ... Colors ...

              const Divider(),
              _buildColorFilter('Shirt Colors', Filter.shirtColor,
                  (List<MyColor> value) {
                setState(() {
                  Filter.shirtColor = value;
                });
              }),

              _buildColorFilter('T-shirt Colors', Filter.tshirtColor,
                  (List<MyColor> value) {
                setState(() {
                  Filter.tshirtColor = value;
                });
              }),

              _buildColorFilter('Pants Colors', Filter.pantsColor,
                  (List<MyColor> value) {
                setState(() {
                  Filter.pantsColor = value;
                });
              }),

              _buildColorFilter('Hat Colors', Filter.hatColor,
                  (List<MyColor> value) {
                setState(() {
                  Filter.hatColor = value;
                });
              }),

              _buildColorFilter('Accessory Colors', Filter.accessoryColor,
                  (List<MyColor> value) {
                setState(() {
                  Filter.accessoryColor = value;
                });
              }),

              _buildColorFilter('Shoes Colors', Filter.shoesColor,
                  (List<MyColor> value) {
                setState(() {
                  Filter.shoesColor = value;
                });
              }),

              ElevatedButton(
                  onPressed: () => setState(() {
                        Provider.of<Filter>(context, listen: false)
                            .resetFilters();
                      }),
                  child: const Text('Reset Filters')),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRadioGroup<T>(String title, List<T> options, T selectedValue,
      void Function(T?)? onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8.0),
        Wrap(
          spacing: 8.0,
          children: options.map<Widget>(
            (T value) {
              final optionLabel = value.toString().split('.')[1];
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Radio<T>(
                    value: value,
                    groupValue: selectedValue,
                    onChanged: onChanged,
                  ),
                  Text(optionLabel),
                ],
              );
            },
          ).toList(),
        ),
        const SizedBox(height: 16.0),
      ],
    );
  }

  Widget _buildColorFilter(String title, List<MyColor> selectedColors,
      void Function(List<MyColor>) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        Wrap(
          spacing: 8.0,
          children: MyColor.values.map<Widget>(
            (MyColor color) {
              final isSelected = selectedColors.contains(color);
              return ChoiceChip(
                label: Text(color.toString().split('.')[1]),
                selected: isSelected,
                onSelected: (isSelected) {
                  setState(() {
                    if (isSelected) {
                      selectedColors.add(color);
                    } else {
                      selectedColors.remove(color);
                    }
                    onChanged(selectedColors);
                  });
                },
              );
            },
          ).toList(),
        ),
        const SizedBox(height: 16.0),
      ],
    );
  }

  Widget _buildNewFilterWithChoiceChip(
      String title, New selectedValue, void Function(New) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        Wrap(
          spacing: 8.0,
          children: New.values.map<Widget>(
            (New newValue) {
              final isSelected = selectedValue == newValue;
              return ChoiceChip(
                label: Text(newValue.toString().split('.')[1]),
                selected: isSelected,
                onSelected: (isSelected) {
                  setState(() {
                    onChanged(isSelected ? newValue : New.all);
                  });
                },
              );
            },
          ).toList(),
        ),
        const SizedBox(height: 16.0),
      ],
    );
  }
}
