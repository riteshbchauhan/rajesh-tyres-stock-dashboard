import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_colors.dart';
import '../../data/models/branch_data_provider.dart';
import '../../data/models/branch_model.dart';
import '../../data/models/tyre_model.dart';
import '../widgets/tyre_inventory_table.dart';
import '../widgets/tyre_operation_dialog.dart';

class BranchDetailsPage extends StatefulWidget {
  final int branchId;

  const BranchDetailsPage({
    Key? key,
    required this.branchId,
  }) : super(key: key);

  @override
  State<BranchDetailsPage> createState() => _BranchDetailsPageState();
}

class _BranchDetailsPageState extends State<BranchDetailsPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    Provider.of<BranchDataProvider>(context, listen: false)
        .setSearchQuery(_searchController.text);
  }

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<BranchDataProvider>(context);
    final branch =
        dataProvider.branches.firstWhere((b) => b.id == widget.branchId);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          branch.name,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: IconButton(
              icon: Icon(
                Icons.add_circle,
                color: AppColors.accentOrange,
                size: 36,
              ),
              tooltip: 'Add Tyre',
              onPressed: () =>
                  _showTyreOperationDialog(context, 'ADD', dataProvider),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(
              MediaQuery.of(context).size.width < 600 ? 8.0 : 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search Bar
              _buildSearchBar(),

              const SizedBox(height: 24),

              const SizedBox(height: 16),

              // Tyre Inventory Table
              LayoutBuilder(
                builder: (context, constraints) {
                  if (constraints.maxWidth >= 900) {
                    // Desktop: center the table
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IntrinsicWidth(
                          child: TyreInventoryTable(
                            tyres: dataProvider.tyres,
                            onEdit: _handleEdit,
                            onDelete: _handleDelete,
                            onSell: (tyreId) {
                              final tyre = dataProvider.tyres
                                  .firstWhere((t) => t.id == tyreId);
                              _showTyreOperationDialog(
                                  context, 'SELL', dataProvider,
                                  tyre: tyre);
                            },
                            onTransfer: (tyreId) {
                              final tyre = dataProvider.tyres
                                  .firstWhere((t) => t.id == tyreId);
                              _showTyreOperationDialog(
                                  context, 'TRANSFER', dataProvider,
                                  tyre: tyre);
                            },
                          ),
                        ),
                      ],
                    );
                  } else {
                    // Mobile/tablet: left-aligned, horizontally scrollable
                    return Scrollbar(
                      thumbVisibility: false,
                      trackVisibility: false,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: IntrinsicWidth(
                          child: TyreInventoryTable(
                            tyres: dataProvider.tyres,
                            onEdit: _handleEdit,
                            onDelete: _handleDelete,
                            onSell: (tyreId) {
                              final tyre = dataProvider.tyres
                                  .firstWhere((t) => t.id == tyreId);
                              _showTyreOperationDialog(
                                  context, 'SELL', dataProvider,
                                  tyre: tyre);
                            },
                            onTransfer: (tyreId) {
                              final tyre = dataProvider.tyres
                                  .firstWhere((t) => t.id == tyreId);
                              _showTyreOperationDialog(
                                  context, 'TRANSFER', dataProvider,
                                  tyre: tyre);
                            },
                          ),
                        ),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.searchBarBackground,
        borderRadius: BorderRadius.circular(8.0),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: TextField(
        controller: _searchController,
        decoration: const InputDecoration(
          hintText: 'Search by tyre name or company...',
          border: InputBorder.none,
          icon: Icon(Icons.search),
        ),
      ),
    );
  }

  void _showTyreOperationDialog(
    BuildContext context,
    String operationType,
    BranchDataProvider dataProvider, {
    TyreModel? tyre,
  }) {
    showDialog(
      context: context,
      builder: (context) => TyreOperationDialog(
        operationType: operationType,
        branchId: widget.branchId,
        branches: dataProvider.branches,
        tyre: tyre,
      ),
    );
  }

  void _handleEdit(int tyreId) {
    final dataProvider =
        Provider.of<BranchDataProvider>(context, listen: false);
    final tyre = dataProvider.tyres.firstWhere((t) => t.id == tyreId);
    showDialog(
      context: context,
      builder: (context) => TyreOperationDialog(
        operationType: 'EDIT',
        branchId: widget.branchId,
        branches: dataProvider.branches,
        tyre: tyre,
        onSubmit: (editedTyre) {
          final index =
              dataProvider.tyres.indexWhere((t) => t.id == editedTyre.id);
          if (index != -1) {
            dataProvider.tyres[index] = editedTyre;
            dataProvider.notifyListeners();
          }
        },
      ),
    );
  }

  void _handleDelete(int tyreId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Delete'),
        content: const Text('Are you sure you want to delete this tyre?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('CANCEL'),
          ),
          TextButton(
            onPressed: () {
              Provider.of<BranchDataProvider>(context, listen: false)
                  .deleteTyre(tyreId);
              Navigator.pop(context);
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.red,
            ),
            child: const Text('DELETE'),
          ),
        ],
      ),
    );
  }
}
