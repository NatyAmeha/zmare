import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:zema/widget/custom_text.dart';

class CustomChip extends StatelessWidget {
  String label;
  Function? onSelected;
  Function? onDeleted;
  CustomChip({
    required this.label,
    this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return InputChip(
      label: CustomText(label, fontSize: 12),
      labelPadding: const EdgeInsets.all(8),
      avatar: const CircleAvatar(
          radius: 10,
          child: Icon(
            Icons.check_circle,
            size: 15,
          )),
      elevation: 4,
      deleteIcon: const Icon(
        Icons.clear,
        size: 15,
      ),
      onDeleted: () {
        onDeleted?.call();
      },
      backgroundColor: Colors.grey[200],
      onSelected: (isSelected) {},
    );
  }
}
