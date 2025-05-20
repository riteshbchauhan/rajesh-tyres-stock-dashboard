import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../data/models/tyre_model.dart';

class TyreInventoryTable extends StatelessWidget {
  final List<TyreModel> tyres;
  final Function(int) onEdit;
  final Function(int) onDelete;
  final Function(int) onSell;
  final Function(int) onTransfer;

  const TyreInventoryTable({
    Key? key,
    required this.tyres,
    required this.onEdit,
    required this.onDelete,
    required this.onSell,
    required this.onTransfer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(top: 16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            headingRowColor: MaterialStateProperty.all(AppColors.primaryBlue),
            headingTextStyle: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            columns: const [
              DataColumn(label: Text('No')),
              DataColumn(label: Text('Tyre Name')),
              DataColumn(label: Text('Company Name')),
              DataColumn(label: Text('Price')),
              DataColumn(label: Text('Qty')),
              DataColumn(label: Text('Options')),
            ],
            rows: tyres.asMap().entries.map((entry) {
              final index = entry.key;
              final tyre = entry.value;
              return DataRow(
                cells: [
                  DataCell(Text('${index + 1}')),
                  DataCell(Text(tyre.name)),
                  DataCell(Text(tyre.company)),
                  DataCell(Text(tyre.price.toStringAsFixed(2))),
                  DataCell(Text(tyre.quantity.toString())),
                  DataCell(
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.shopping_cart,
                              color: AppColors.accentOrange),
                          onPressed: () => onSell(tyre.id),
                          tooltip: 'Sell',
                        ),
                        IconButton(
                          icon: const Icon(Icons.swap_horiz,
                              color: AppColors.primaryBlue),
                          onPressed: () => onTransfer(tyre.id),
                          tooltip: 'Transfer',
                        ),
                        IconButton(
                          icon: const Icon(Icons.edit,
                              color: AppColors.primaryBlue),
                          onPressed: () => onEdit(tyre.id),
                          tooltip: 'Edit',
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => onDelete(tyre.id),
                          tooltip: 'Delete',
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
