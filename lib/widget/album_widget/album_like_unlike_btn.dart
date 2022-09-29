import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class AlbumLikeUnlikeBtn extends StatelessWidget {
  Widget likeWidget;
  Widget unlikeWidget;
  Function positiveAction;
  Function negetiveAction;
  String albumId;
  bool state;
  bool isLoading;
  AlbumLikeUnlikeBtn({
    this.likeWidget = const Icon(Icons.favorite_outline, color: Colors.grey),
    this.unlikeWidget = const Icon(Icons.favorite, color: Colors.grey),
    required this.albumId,
    required this.positiveAction,
    required this.negetiveAction,
    this.state = false,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const SizedBox(
        height: 10,
        child: CircularProgressIndicator(),
      );
    } else {
      return state
          ? InkWell(
              onTap: () async {
                negetiveAction();
              },
              child: unlikeWidget)
          : InkWell(
              onTap: () async {
                positiveAction();
              },
              child: likeWidget);
    }
  }
}
