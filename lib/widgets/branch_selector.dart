import 'package:cuchos_market_mobile/models/branches.dart';
import 'package:flutter/material.dart';

class BranchSelector extends StatefulWidget {
  const BranchSelector({Key? key}) : super(key: key);

  @override
  State<BranchSelector> createState() => _BranchSelectorState();
}

class _BranchSelectorState extends State<BranchSelector> {
  int selectedItem = Branches().selectedBranch.value.id ?? 1;

  void selectBranch(int branchId) {
    selectedItem = branchId;
    Branches().selectedBranch.value = Branches().branches.value[selectedItem]!;
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Branches().branches,
      builder: (context, branches, child) => Container(
        margin: const EdgeInsets.all(10),
        child: DropdownButtonHideUnderline(
          child: DropdownButton(
            isExpanded: true,
            icon: const Icon(Icons.location_on),
            focusColor: Colors.transparent,
            value: selectedItem,
            items: branches.values
                .map(
                  (branch) => DropdownMenuItem(
                    value: branch.id,
                    child: Text(branch.name!),
                  ),
                )
                .toList(),
            onChanged: (branch) => selectBranch(branch!),
          ),
        ),
      ),
    );
  }
}
