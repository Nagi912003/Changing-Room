

import 'package:flutter/material.dart';

import '../models/piece.dart';

class ClothesSelectorProvider with ChangeNotifier {
  Piece? selectedHat;
  Piece? selectedAccessories;
  Piece? selectedShirt;
  Piece? selectedTshirt;
  Piece? selectedPants;
  Piece? selectedShoes;
  Piece? selectedJacket;

  ClothesSelectorProvider({
    this.selectedHat,
    this.selectedAccessories,
    this.selectedShirt,
    this.selectedTshirt,
    this.selectedPants,
    this.selectedShoes,
    this.selectedJacket,
  });

  void selectPiece(Piece? piece) {
    switch (piece!.category) {
      case MyCategory.shirt:
        selectedShirt = piece;
        break;
      case MyCategory.tshirt:
        selectedTshirt = piece;
        break;
      case MyCategory.pants:
        selectedPants = piece;
        break;
      case MyCategory.shoes:
        selectedShoes = piece;
        break;
      case MyCategory.hat:
        selectedHat = piece;
        break;
      case MyCategory.accessory:
        selectedAccessories = piece;
        break;
      case MyCategory.jacket:
        selectedJacket = piece;
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
    if (selectedJacket == piece) selectedJacket = null;
    notifyListeners();
  }
  bool isPieceSelected(Piece? piece) {
    switch (piece!.category) {
      case MyCategory.shirt:
        return selectedShirt == piece;
      case MyCategory.tshirt:
        return selectedTshirt == piece;
      case MyCategory.pants:
        return selectedPants == piece;
      case MyCategory.shoes:
        return selectedShoes == piece;
      case MyCategory.hat:
        return selectedHat == piece;
      case MyCategory.accessory:
        return selectedAccessories == piece;
      case MyCategory.jacket:
        return selectedJacket == piece;
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
    selectedJacket = null;
    notifyListeners();
  }
}