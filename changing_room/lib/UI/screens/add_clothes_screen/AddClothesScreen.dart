import 'dart:io';

import 'package:changing_room/Data/models/piece.dart';
import 'package:changing_room/Data/providers/clothes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../pick_image_screen/pick_image_screen.dart';

class AddClothesScreen extends StatefulWidget {
  const AddClothesScreen({super.key});

  @override
  State<AddClothesScreen> createState() => _AddClothesScreenState();
}

class _AddClothesScreenState extends State<AddClothesScreen> {
  String pieceId = '';
  // List<String> imagePaths = [];
  MyCategory selectedCategory = MyCategory.general;
  List<MyColor> selectedColors = [MyColor.all];
  OutDoors selectedOutDoors = OutDoors.all;
  ForWeather selectedForWeather = ForWeather.all;
  // Brightness selectedBrightness = Brightness.all;
  Fit selectedFit = Fit.all;

  @override
  Widget build(BuildContext context) {
    final clothes = Provider.of<Clothes>(context);
    final imagesInput = clothes.imagesInput;
    pieceId = clothes.id;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Piece'),
        leading: IconButton(
          onPressed: () {
            clothes.imagesInput.clear();
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              selectCategoryWithChoiceChips(
                  title: 'Category',
                  selectedValue: selectedCategory,
                  onChanged: (MyCategory value) {
                    setState(() {
                      selectedCategory = value;
                    });
                  }),
              imagesInput.isEmpty?SizedBox(
                height: 200,
                width: 200,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => PickImageScreen(pieceId: pieceId,selectedCategory: selectedCategory),
                          ),
                        );
                      },
                      icon: const Icon(Icons.camera_alt,size: 70,),
                    ),
                  ),
                ),
              ): SizedBox(
                height: 100,
                width: MediaQuery.sizeOf(context).width - 16,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: imagesInput.length,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      height: 100,
                      width: 100,
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.file(
                              File(imagesInput[index]),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16.0),
              selectColorsWithChoiceChips(
                  title: 'Colors',
                  selectedColors: selectedColors,
                  onChanged: (List<MyColor> value) {
                    setState(() {
                      selectedColors = value;
                    });
                  }),
              //          ... Global filters ...
              _buildRadioGroup('Going out??', OutDoors.values, selectedOutDoors,
                      (value) {
                    setState(() {
                      selectedOutDoors = value!;
                    });
                  }),
              _buildRadioGroup('Weather', ForWeather.values, selectedForWeather,
                      (value) {
                    setState(() {
                      selectedForWeather = value!;
                    });
                  }),
              _buildRadioGroup('Fit', Fit.values, selectedFit, (value) {
                setState(() {
                  selectedFit = value!;
                });
              }),
              const SizedBox(height: 16.0),
              Center(
                child: CupertinoButton.filled(
                  onPressed: () {
                    // print(imagesInput);
                    final List<String> imagesPaths = List <String>.from(imagesInput);
                    final piece = Piece(
                      id: pieceId,
                      images: imagesPaths,
                      colors: selectedColors,
                      category: selectedCategory,
                      fit: selectedFit,
                      outDoors: selectedOutDoors,
                      forWeather: selectedForWeather,
                    );
                    // print('images from addScreen : ${piece.images}');
                    // savePiece(piece);
                    clothes.addPiece(piece);
                    clothes.imagesInput.clear();
                    Navigator.of(context).pop();
                  },
                  child: const Text('Add Piece'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget selectCategoryWithChoiceChips(
      {required String title,
      required MyCategory selectedValue,
      required ValueChanged<MyCategory> onChanged}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        Wrap(
          spacing: 8.0,
          children: MyCategory.values.map<Widget>(
            (MyCategory newValue) {
              final isSelected = selectedValue == newValue;
              return ChoiceChip(
                label: Text(newValue.toString().split('.')[1]),
                selected: isSelected,
                onSelected: (isSelected) {
                  setState(() {
                    onChanged(isSelected ? newValue : MyCategory.tshirt);
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

  Widget selectColorsWithChoiceChips(
      {required String title,
      required List<MyColor> selectedColors,
      required void Function(List<MyColor>) onChanged}) {
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
}
