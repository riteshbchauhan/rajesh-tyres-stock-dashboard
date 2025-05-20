import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';
import '../../../../core/constants/app_colors.dart';
import '../../data/models/branch_model.dart';

class TyreInventoryTable extends StatelessWidget {
  final List<TyreModel> tyres;
  final Function(int) onEdit;
  final Function(int) onDelete;

  const TyreInventoryTable({
    Key? key,
    required this.tyres,
    required this.onEdit,
    required this.onDelete,
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
        child: DataTable2(
          columnSpacing: 12,
          horizontalMargin: 12,
          minWidth: 600,
          columns: const [
            DataColumn2(
              label: Text(
                'NO.',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              size: ColumnSize.S,
            ),
            DataColumn2(
              label: Text(
                'Tyre name',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              size: ColumnSize.L,
            ),
            DataColumn2(
              label: Text(
                'Company name',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              size: ColumnSize.M,
            ),
            DataColumn2(
              label: Text(
                'Price',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              size: ColumnSize.S,
            ),
            DataColumn2(
              label: Text(
                'QTY',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              size: ColumnSize.S,
            ),
            DataColumn2(
              label: Text(''),
              size: ColumnSize.S,
            ),
          ],
          rows: List<DataRow>.generate(
            tyres.length,
            (index) => DataRow(
              cells: [
                DataCell(Text('${index + 1}.')),
                DataCell(Text(tyres[index].name)),
                DataCell(Text(tyres[index].company)),
                DataCell(Text(tyres[index].price.toStringAsFixed(0))),
                DataCell(Text('${tyres[index].quantity}')),
                DataCell(
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.edit,
                          color: AppColors.accentOrange,
                        ),
                        onPressed: () => onEdit(tyres[index].id),
                        tooltip: 'Edit',
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        onPressed: () => onDelete(tyres[index].id),
                        tooltip: 'Delete',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
