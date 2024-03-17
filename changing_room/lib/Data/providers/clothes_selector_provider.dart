

import 'package:flutter/material.dart';

import '../models/piece.dart';

class ClothesSelectorProvider with ChangeNotifier {
  Piece? selectedHat;
  Piece? selectedAccessories;
  Piece? selectedShirt;
  Piece? selectedTshirt;
  Piece? selectedPants;
  Piece? selectedShoes;

  ClothesSelectorProvider({
    this.selectedHat,
    this.selectedAccessories,
    this.selectedShirt,
    this.selectedTshirt,
    this.selectedPants,
    this.selectedShoes,
  });

  void selectPiece(Piece? piece) {
    switch (piece!.category) {
      case Category.shirt:
        selectedShirt = piece;
        break;
      case Category.tshirt:
        selectedTshirt = piece;
        break;
      case Category.pants:
        selectedPants = piece;
        break;
      case Category.shoes:
        selectedShoes = piece;
        break;
      case Category.hat:
        selectedHat = piece;
        break;
      case Category.accessory:
        selectedAccessories = piece;
        break;
      default:
    }
    notifyListeners();
  }
  void deselectPiece(Piece? piece) {
    if (selectedHat == piece) selectedHat = null;
    if (selectedAccessories == piece) selectedAccessories = null;
    if (selectedShirt == piece) selectedShirt = null;
    if (selectedTshirt == piece) selectedTshirt = null;
    if (selectedPants == piece) selectedPants = null;
    if (selectedShoes == piece) selectedShoes = null;
    notifyListeners();
  }
  bool isPieceSelected(Piece? piece) {
    switch (piece!.category) {
      case Category.shirt:
        return selectedShirt == piece;
      case Category.tshirt:
        return selectedTshirt == piece;
      case Category.pants:
        return selectedPants == piece;
      case Category.shoes:
        return selectedShoes == piece;
      case Category.hat:
        return selectedHat == piece;
      case Category.accessory:
        return selectedAccessories == piece;
      default:
        return false;
    }
  }
  void toggleSelected(Piece? piece) {
    if (isPieceSelected(piece)) {
      deselectPiece(piece);
    } else {
      selectPiece(piece);
    }
  }
  void deselectAll() {
    selectedHat = null;
    selectedAccessories = null;
    selectedShirt = null;
    selectedTshirt = null;
    selectedPants = null;
    selectedShoes = null;
    notifyListeners();
  }
}