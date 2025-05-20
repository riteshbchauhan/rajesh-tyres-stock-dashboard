import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_colors.dart';
import '../../data/models/branch_data_provider.dart';
import '../../data/models/tyre_model.dart';
import '../../data/models/branch_model.dart';

class TyreOperationDialog extends StatefulWidget {
  final String operationType;
  final int branchId;
  final List<BranchModel> branches;
  final TyreModel? tyre;
  final void Function(TyreModel)? onSubmit;

  const TyreOperationDialog({
    Key? key,
    required this.operationType,
    required this.branchId,
    required this.branches,
    this.tyre,
    this.onSubmit,
  }) : super(key: key);

  @override
  State<TyreOperationDialog> createState() => _TyreOperationDialogState();
}

class _TyreOperationDialogState extends State<TyreOperationDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _companyController = TextEditingController();
  final _quantityController = TextEditingController();
  final _priceController = TextEditingController();
  int? _selectedBranchId;

  @override
  void initState() {
    super.initState();
    if (widget.tyre != null) {
      _nameController.text = widget.tyre!.name;
      _companyController.text = widget.tyre!.company;
      _quantityController.text = '1';
      _priceController.text = widget.tyre!.price.toString();
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _companyController.dispose();
    _quantityController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      final dataProvider =
          Provider.of<BranchDataProvider>(context, listen: false);
      final quantity = int.parse(_quantityController.text);
      final price = double.tryParse(_priceController.text) ?? 0;

      try {
        switch (widget.operationType) {
          case 'ADD':
            dataProvider.addTyre(
              TyreModel(
                id: DateTime.now().millisecondsSinceEpoch,
                name: _nameController.text,
                company: _companyController.text,
                price: price,
                quantity: quantity,
              ),
            );
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Added $quantity tyres successfully')),
            );
            break;
          case 'EDIT':
            if (widget.tyre == null) throw Exception('No tyre to edit');
            final editedTyre = TyreModel(
              id: widget.tyre!.id,
              name: _nameController.text,
              company: _companyController.text,
              price: price,
              quantity: quantity,
            );
            if (widget.onSubmit != null) widget.onSubmit!(editedTyre);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Tyre updated successfully')),
            );
            break;
          case 'SELL':
            if (widget.tyre == null) {
              throw Exception('No tyre selected for selling');
            }
            if (widget.tyre!.quantity < quantity) {
              throw Exception('Not enough stock available');
            }
            dataProvider.sellTyre(widget.tyre!.id, quantity);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Sold $quantity tyres successfully')),
            );
            break;

          case 'TRANSFER':
            if (widget.tyre == null) {
              throw Exception('No tyre selected for transfer');
            }
            if (_selectedBranchId == null) {
              throw Exception('Please select a target branch');
            }
            if (widget.tyre!.quantity < quantity) {
              throw Exception('Not enough stock available');
            }
            dataProvider.transferTyre(
              widget.tyre!.id,
              widget.branchId,
              _selectedBranchId!,
              quantity,
            );
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text('Transferred $quantity tyres successfully')),
            );
            break;
        }
        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final dialogWidth = screenWidth < 500 ? screenWidth * 0.9 : 400.0;
    return AlertDialog(
      title: Text('${widget.operationType} Tyre'),
      content: SizedBox(
        width: dialogWidth,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.operationType == 'ADD') ...[
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Tyre Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter tyre name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _companyController,
                  decoration: const InputDecoration(
                    labelText: 'Company',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter company name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _priceController,
                  decoration: const InputDecoration(
                    labelText: 'Price',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter price';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Please enter a valid price';
                    }
                    if (double.parse(value) <= 0) {
                      return 'Price must be greater than 0';
                    }
                    return null;
                  },
                ),
              ],
              const SizedBox(height: 16),
              TextFormField(
                controller: _quantityController,
                decoration: const InputDecoration(
                  labelText: 'Quantity',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter quantity';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  if (int.parse(value) <= 0) {
                    return 'Quantity must be greater than 0';
                  }
                  return null;
                },
              ),
              if (widget.operationType == 'TRANSFER') ...[
                const SizedBox(height: 16),
                DropdownButtonFormField<int>(
                  value: _selectedBranchId,
                  decoration: const InputDecoration(
                    labelText: 'Target Branch',
                    border: OutlineInputBorder(),
                  ),
                  items: widget.branches
                      .where((branch) => branch.id != widget.branchId)
                      .map((branch) {
                    return DropdownMenuItem<int>(
                      value: branch.id,
                      child: Text(branch.name),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedBranchId = value;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Please select a target branch';
                    }
                    return null;
                  },
                ),
              ],
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('CANCEL'),
        ),
        ElevatedButton(
          onPressed: _handleSubmit,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.accentOrange,
            foregroundColor: Colors.white,
          ),
          child: const Text('SUBMIT'),
        ),
      ],
    );
  }
}
