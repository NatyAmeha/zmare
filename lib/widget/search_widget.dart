import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:zmare/widget/custom_container.dart';

class SearchBar extends StatelessWidget {
  String hintText;
  bool isActive;
  double borderRadius;
  IconData? prefixIcon;
  Function? prefixIconAction;

  SearchBar({
    this.hintText = "Search songs, albums and playlists",
    this.prefixIcon,
    this.prefixIconAction,
    this.borderRadius = 32,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      color: Theme.of(context).backgroundColor,
      padding: 16,
      borderRadius: borderRadius,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (prefixIcon != null)
            InkWell(
                onTap: prefixIconAction?.call(),
                child: Icon(prefixIcon, size: 20)),
          Text(
            hintText,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
          ),
          const Icon(Icons.search)
        ],
      ),
    );
  }
}
