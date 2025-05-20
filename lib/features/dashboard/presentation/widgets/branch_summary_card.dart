import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../data/models/branch_model.dart';

class BranchSummaryCard extends StatelessWidget {
  final BranchModel branch;
  final bool isActive;
  final VoidCallback onTap;
  final VoidCallback? onAdd;

  const BranchSummaryCard({
    Key? key,
    required this.branch,
    this.isActive = false,
    required this.onTap,
    this.onAdd,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: isActive ? 4 : 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
          side: BorderSide(
            color: isActive ? AppColors.accentOrange : AppColors.borderColor,
            width: isActive ? 2.0 : 1.0,
          ),
        ),
        child: SizedBox(
          height: 160,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Branch header
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: 16.0,
                ),
                decoration: const BoxDecoration(
                  color: AppColors.accentOrange,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(7.0),
                    topRight: Radius.circular(7.0),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        branch.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),

              // Tyre stock list
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildStockRow('MRF', branch.tyreStock['MRF'] ?? 0),
                      _buildStockRow('CEAT', branch.tyreStock['CEAT'] ?? 0),
                      _buildStockRow('APOLLO', branch.tyreStock['APOLLO'] ?? 0),
                      _buildStockRow('JK', branch.tyreStock['JK'] ?? 0),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStockRow(String brand, int quantity) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          brand,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 12.0,
          ),
        ),
        Text(
          quantity == 0 ? '—' : quantity.toString(),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14.0,
            color: quantity < 20 ? Colors.red : Colors.black,
          ),
        ),
      ],
    );
  }
}
