import 'package:flutter/cupertino.dart';

class MenuViewmodel {
  String text;
  String? subtitle;
  IconData icon;

  int type;

  Function(int)? onClick;

  MenuViewmodel({
    required this.text,
    required this.icon,
    required this.type,
    this.subtitle,
    this.onClick,
  });

  static const MENU_TYPE_LIKE_UNLIKE_SONG = 0;

  static const MENU_TYPE_DOWNLOAD_REMOVE_DOWNLOAD_SONG = 1;

  static const MENU_TYPE_DELETE_SONG = 4;

  static const MENU_TYPE_GO_TO_ALBUM = 5;

  static const MENU_TYPE_GO_TO_ARTIST = 6;

  static const MENU_TYPE_ADD_TO_PLAYLIST_SONG = 7;
  static const MENU_TYPE_REMOVE_FROM_PLAYLIST_SONG = 8;

  static const MENU_TYPE_LIKE_ALBUM = 9;

  static const MENU_TYPE_UNLIKE_ALBUM = 10;

  static const MENU_TYPE_DOWNLOAD_ALBUM = 11;

  static const MENU_TYPE_REMOVE_DOWNLOAD_ALBUM = 12;
}
