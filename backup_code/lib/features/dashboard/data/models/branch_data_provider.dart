import 'package:flutter/material.dart';
import 'branch_model.dart';

class BranchDataProvider extends ChangeNotifier {
  // Sample data for initial state
  final List<BranchModel> _branches = [
    BranchModel(
      id: 1,
      name: 'Branch 1',
      tyreStock: {
        'MRF': 80,
        'CEAT': 75,
        'APOLLO': 50,
        'JK': 90,
      },
    ),
    BranchModel(
      id: 2,
      name: 'Branch 2',
      tyreStock: {
        'MRF': 80,
        'CEAT': 75,
        'APOLLO': 50,
        'JK': 90,
      },
    ),
    BranchModel(
      id: 3,
      name: 'Branch 3',
      tyreStock: {
        'MRF': 60,
        'CEAT': 60,
        'APOLLO': 0,
        'JK': 90,
      },
    ),
    BranchModel(
      id: 4,
      name: 'Branch 4',
      tyreStock: {
        'MRF': 45,
        'CEAT': 30,
        'APOLLO': 20,
        'JK': 60,
      },
    ),
  ];

  // Sample tyre data
  final List<TyreModel> _tyres = [
    TyreModel(
      id: 1,
      name: '90/100-10 CEAT Milaze TL',
      company: 'CEAT',
      price: 1350,
      quantity: 40,
    ),
    TyreModel(
      id: 2,
      name: '120/80-17 MRF Revz-FC',
      company: 'MRF',
      price: 2650,
      quantity: 25,
    ),
    TyreModel(
      id: 3,
      name: '100/90-17 APOLLO ActiZip F3',
      company: 'APOLLO',
      price: 1850,
      quantity: 15,
    ),
  ];

  // Active branch to display
  int _activeBranchId = 1;

  // Getters
  List<BranchModel> get branches => _branches;
  List<TyreModel> get tyres => _tyres.where((tyre) => 
    _branches.firstWhere((branch) => branch.id == _activeBranchId)
      .tyreStock.containsKey(tyre.company)
  ).toList();
  int get activeBranchId => _activeBranchId;
  
  // Get active branch
  BranchModel get activeBranch => 
    _branches.firstWhere((branch) => branch.id == _activeBranchId);

  // Set active branch
  void setActiveBranch(int branchId) {
    _activeBranchId = branchId;
    notifyListeners();
  }

  // Add a new tyre
  void addTyre(TyreModel tyre) {
    _tyres.add(tyre);
    notifyListeners();
  }

  // Update tyre stock
  void updateTyreStock(int branchId, String company, int newStock) {
    final branch = _branches.firstWhere((branch) => branch.id == branchId);
    branch.tyreStock[company] = newStock;
    notifyListeners();
  }

  // Delete a tyre
  void deleteTyre(int tyreId) {
    _tyres.removeWhere((tyre) => tyre.id == tyreId);
    notifyListeners();
  }
} 