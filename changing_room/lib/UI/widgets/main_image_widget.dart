import 'dart:io';

import 'package:flutter/material.dart';

import '../../Data/models/piece.dart';

Widget mainImage({
  required BuildContext context,
  required double widthXHeight,
  Piece? selectedTshirt,
  Piece? selectedPants,
  Piece? selectedShoes,
  Piece? selectedHat,
  Piece? selectedAccessory,
  Piece? selectedShirt,
  Piece? selectedJacket,
}) {
  return SizedBox(
    width: widthXHeight,
    height: widthXHeight,
    child: Card(
      child: Stack(
        children: [
          //jackt
          if (selectedJacket != null)
            Align(
              // alignment: const Alignment(0.75, 0),
              child: SizedBox(
                width: MediaQuery.sizeOf(context).width,
                height: MediaQuery.sizeOf(context).width,
                child: Image.file(
                  File(selectedJacket.images[0]),
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
          //pants
          if (selectedPants != null)
            Align(
              // alignment: const Alignment(-0.75, 0),
              child: SizedBox(
                // color: Colors.brown.shade200,
                width: MediaQuery.sizeOf(context).width,
                height: MediaQuery.sizeOf(context).width,
                child: Image.file(
                  File(selectedPants.images[selectedTshirt != null || selectedJacket != null?1:0]),
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
          //t-shirt
          if (selectedTshirt != null)
            Align(
              // alignment: const Alignment(0.75, 0),
              child: SizedBox(
                width: MediaQuery.sizeOf(context).width,
                height: MediaQuery.sizeOf(context).width,
                child: Image.file(
                  File(selectedTshirt.images[selectedPants != null || selectedJacket != null?1:0]),
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
          //hat
          if (selectedHat != null)
            Align(
              // alignment: const Alignment(0.8, 0.5),
              child: SizedBox(
                width: MediaQuery.sizeOf(context).width,
                height: MediaQuery.sizeOf(context).width,
                child: Image.file(
                  File(selectedHat.images[0]),
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
          //accessory
          if (selectedAccessory != null)
            Align(
              alignment: const Alignment(-1, -0.40),
              child: SizedBox(
                width: MediaQuery.sizeOf(context).width,
                height: MediaQuery.sizeOf(context).width,
                child: Image.file(
                  File(selectedAccessory.images[0]),
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
          //shoes
          if (selectedShoes != null)
            Align(
              alignment: const Alignment(-1, 1.5),
              child: Container(
                // transform: Matrix4.rotationZ(-0.9),
                // color: Colors.brown.shade200,
                width: MediaQuery.sizeOf(context).width - 70,
                height: MediaQuery.sizeOf(context).width - 70,
                child: Image.file(
                  File(selectedShoes.images[0]),
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
        ],
      ),
    ),
  );
}
