import 'package:cuchos_market_mobile/utilities/branch_controller.dart';
import 'package:cuchos_market_mobile/utilities/product_controller.dart';
import 'package:flutter/material.dart';

class BranchSelector extends StatefulWidget {
  const BranchSelector({Key? key}) : super(key: key);

  @override
  State<BranchSelector> createState() => _BranchSelectorState();
}

class _BranchSelectorState extends State<BranchSelector> {
  int selectedItem = BranchController().selectedBranch.value.id ?? 1;

  void selectBranch(int branchId) {
    selectedItem = branchId;
    BranchController().selectedBranch.value = BranchController().branches.value[selectedItem]!;

    ProductController().loadProducts();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: BranchController().branches,
      builder: (context, branches, child) => DropdownButtonHideUnderline(
        child: DropdownButton(
          isExpanded: true,
          icon: Container(
            margin: const EdgeInsets.all(10),
            child: const Icon(Icons.location_on),
          ),
          focusColor: Colors.transparent,
          value: selectedItem,
          items: branches.values
              .map(
                (branch) => DropdownMenuItem(
                  value: branch.id,
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    child: Text(branch.name!),
                  ),
                ),
              )
              .toList(),
          onChanged: (branch) => selectBranch(branch!),
        ),
      ),
    );
  }
}
