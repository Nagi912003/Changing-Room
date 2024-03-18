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
}) {
  return SizedBox(
    width: widthXHeight,
    height: widthXHeight,
    child: Card(
      child: Stack(
        children: [
          //t-shirt
          if (selectedTshirt != null)
            Align(
              // alignment: const Alignment(0.75, 0),
              child: SizedBox(
                width: MediaQuery.sizeOf(context).width - 70,
                height: MediaQuery.sizeOf(context).width - 70,
                child: Image.asset(
                  selectedTshirt.images[0],
                  fit: BoxFit.contain,
                ),
              ),
            ),
          //pants
          if (selectedPants != null)
            Align(
              // alignment: const Alignment(-0.75, 0),
              child: SizedBox(
                // color: Colors.brown.shade200,
                width: MediaQuery.sizeOf(context).width - 70,
                height: MediaQuery.sizeOf(context).width - 70,
                child: Image.asset(
                  selectedPants.images[0],
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
          //hat
          if (selectedHat != null)
            Align(
              // alignment: const Alignment(0.8, 0.5),
              child: SizedBox(
                width: MediaQuery.sizeOf(context).width - 70,
                height: MediaQuery.sizeOf(context).width - 70,
                child: Image.asset(
                  selectedHat.images[0],
                  fit: BoxFit.contain,
                ),
              ),
            ),
          //accessory
          if (selectedAccessory != null)
            Align(
              alignment: const Alignment(-1, -0.40),
              child: SizedBox(
                width: MediaQuery.sizeOf(context).width - 70,
                height: MediaQuery.sizeOf(context).width - 70,
                child: Image.asset(
                  selectedAccessory.images[0],
                  fit: BoxFit.contain,
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
                child: Image.asset(
                  selectedShoes.images[0],
                  fit: BoxFit.contain,
                ),
              ),
            ),
        ],
      ),
    ),
  );
}