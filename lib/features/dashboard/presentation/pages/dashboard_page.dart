import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../../../../core/constants/app_colors.dart';
import '../../data/models/branch_data_provider.dart';
import '../widgets/branch_summary_card.dart';
import '../widgets/tyre_inventory_table.dart';
import 'branch_details_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<BranchDataProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Rajesh Tyres & Co.',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height + 100,
          ),
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              16.0,
              16.0,
              16.0,
              MediaQuery.of(context).size.width < 900 ? 48.0 : 16.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Dashboard',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),

                // Branch Summary Cards
                _buildBranchSummarySection(context, dataProvider),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBranchSummarySection(
      BuildContext context, BranchDataProvider dataProvider) {
    return ResponsiveRowColumn(
      layout: MediaQuery.of(context).size.width < 900
          ? ResponsiveRowColumnType.COLUMN
          : ResponsiveRowColumnType.ROW,
      rowCrossAxisAlignment: CrossAxisAlignment.start,
      children: dataProvider.branches.map((branch) {
        return ResponsiveRowColumnItem(
          rowFlex: 1,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BranchDetailsPage(
                      branchId: branch.id,
                    ),
                  ),
                );
              },
              child: BranchSummaryCard(
                branch: branch,
                isActive: branch.id == dataProvider.activeBranchId,
                onTap: () {
                  dataProvider.setActiveBranch(branch.id);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BranchDetailsPage(
                        branchId: branch.id,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  void _handleEdit(int tyreId) {
    // Implement edit functionality
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Edit tyre ID: $tyreId')),
    );
  }

  void _handleDelete(int tyreId) {
    // Show confirmation dialog
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
