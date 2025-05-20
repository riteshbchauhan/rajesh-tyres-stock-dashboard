import 'package:flutter/material.dart';
import 'tyre_model.dart';
import 'branch_model.dart';

class BranchDataProvider with ChangeNotifier {
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

  String _searchQuery = '';
  int _activeBranchId = 1;

  List<BranchModel> get branches => _branches;
  int get activeBranchId => _activeBranchId;
  BranchModel get activeBranch =>
      _branches.firstWhere((b) => b.id == _activeBranchId);

  List<TyreModel> get tyres => _filterTyres();

  void setActiveBranch(int branchId) {
    _activeBranchId = branchId;
    notifyListeners();
  }

  void setSearchQuery(String query) {
    _searchQuery = query.toLowerCase();
    notifyListeners();
  }

  List<TyreModel> _filterTyres() {
    if (_searchQuery.isEmpty) {
      return _tyres;
    }
    return _tyres.where((tyre) {
      return tyre.name.toLowerCase().contains(_searchQuery) ||
          tyre.company.toLowerCase().contains(_searchQuery);
    }).toList();
  }

  void addTyre(TyreModel tyre) {
    final existingTyreIndex = _tyres.indexWhere(
      (t) => t.name == tyre.name && t.company == tyre.company,
    );

    if (existingTyreIndex != -1) {
      // Update existing tyre quantity
      _tyres[existingTyreIndex].quantity += tyre.quantity;
    } else {
      // Add new tyre
      _tyres.add(tyre);
    }

    // Update branch stock
    final branch = _branches.firstWhere((b) => b.id == _activeBranchId);
    branch.tyreStock[tyre.company] =
        (branch.tyreStock[tyre.company] ?? 0) + tyre.quantity;

    notifyListeners();
  }

  void sellTyre(int tyreId, int quantity) {
    final tyreIndex = _tyres.indexWhere((tyre) => tyre.id == tyreId);
    if (tyreIndex != -1) {
      final tyre = _tyres[tyreIndex];
      if (tyre.quantity >= quantity) {
        tyre.quantity -= quantity;

        // Update branch stock
        final branch = _branches.firstWhere((b) => b.id == _activeBranchId);
        branch.tyreStock[tyre.company] =
            (branch.tyreStock[tyre.company] ?? 0) - quantity;

        if (tyre.quantity <= 0) {
          _tyres.removeAt(tyreIndex);
        }
        notifyListeners();
      }
    }
  }

  void transferTyre(
      int tyreId, int fromBranchId, int toBranchId, int quantity) {
    final tyreIndex = _tyres.indexWhere((tyre) => tyre.id == tyreId);
    if (tyreIndex != -1) {
      final tyre = _tyres[tyreIndex];
      if (tyre.quantity >= quantity) {
        // Update source branch stock
        final fromBranch = _branches.firstWhere((b) => b.id == fromBranchId);
        fromBranch.tyreStock[tyre.company] =
            (fromBranch.tyreStock[tyre.company] ?? 0) - quantity;

        // Update destination branch stock
        final toBranch = _branches.firstWhere((b) => b.id == toBranchId);
        toBranch.tyreStock[tyre.company] =
            (toBranch.tyreStock[tyre.company] ?? 0) + quantity;

        // Update tyre quantity
        tyre.quantity -= quantity;
        if (tyre.quantity <= 0) {
          _tyres.removeAt(tyreIndex);
        }

        notifyListeners();
      }
    }
  }

  void deleteTyre(int tyreId) {
    final tyre = _tyres.firstWhere((t) => t.id == tyreId);
    final branch = _branches.firstWhere((b) => b.id == _activeBranchId);

    // Update branch stock
    branch.tyreStock[tyre.company] =
        (branch.tyreStock[tyre.company] ?? 0) - tyre.quantity;

    _tyres.removeWhere((tyre) => tyre.id == tyreId);
    notifyListeners();
  }
}
