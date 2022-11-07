import 'package:flutter/material.dart';
import 'package:zmare/viewmodels/browse_viewmodel.dart';

class Constants {
  // preference constants
  static const REGISTERED = "REGISTEREND";
  static const LOGGED_IN = "LOGGED_IN";
  static const SHOW_ONBOARDING = "SHOW_ONBOARDING";
  static const SHOW_PREIVEW_ONBOARDING = "SHOW_PREVIEW_ONBOARDING";

  static const USER_ID = "USER_ID";
  static const TOKEN = "TOKEN";
  static const USERNAME = "USER_NAME";
  static const PHONE_NUMBER = "PHONE_NUMBER";
  static const PROFILE_IMAGE = "PROFILE_IMAGE";

  static const DEFAULT_NOTIFICATION_CHANNEL_ID =
      "DEFAULT_NOTIFICATION_CHANNEL_ID";
  static const DEFAULT_NOTIFICATION_CHANNEL_NAME =
      "DEFAULT_NOTIFICATION_CHANNEL_NAME";

  static const vapidKey =
      "BNF7a4kf4zaSn9_bNFaJefaBVsS4Hod8Tttrp_5x-pjAJcvWheK_HETKdJTS0C06vxUWzuACoam6cdw4ZphIaxs";

  static const DOWNLOAD_ID_FOR_SINGLE_SONGS = "111";
  static const DONWLOAD_NAME_FORM_SINGLE_SONGS = "Downloaded songs";

  static var browseCommand = [
    BrowseCommand(name: "Worship", icon: Icons.dashboard, tags: [
      "worship",
      "praise",
      "chikchika" "dance",
      "Worship",
      "fast",
      "relax"
    ]),
    BrowseCommand(
        name: "Prayer time",
        icon: Icons.center_focus_strong,
        tags: ["slow", "message", "soul", "love", "fast", "mercy", "focus"]),
    BrowseCommand(name: "Collection", icon: Icons.collections, tags: [
      "collaboration",
      "collection",
      "dance",
      "Worship",
      "fast",
    ]),
    BrowseCommand(
        name: "Old songs",
        icon: Icons.folder_copy_outlined,
        tags: ["oldies", "old"]),
    BrowseCommand(name: "Oromigna", icon: Icons.language, tags: ["oromigna"]),
  ];

  // setting constants
  static const IS_DARK_THEME = "IS_DARK_THEME";
  static const LANGUAGE = "LANGUAGE";
  static const GAPLESS_pLAYBACK = "GAPLESS_PLAYBACK";
}

enum SnackbarType { ERROR_SNACKBAR, SUCCESS_SNACKBAR }

enum AlbumListType { ALBUM_GRID_LIST, ALBUM_HORIZONTAL_LIST }

enum PlaylistListType { HORIZONTAL, GRID }

enum ListSelectionState { SINGLE_SELECTION, MULTI_SELECTION }

enum AudioSrcType { NETWORK, LOCAL_STORAGE, DOWNLOAD }

enum AlbumListDataType { USER_FAVORITE_ALBUM_LIST }

enum SongListDatatype { USER_FAVORITE_SONGS, FROM_PREVIOUS_PAGE }

enum PlaylistListDatatype { USER_FAVORITE_PLAYLIST, CHARTS }

enum RecentActivityTypes { ALBUM, ARTIST, PLAYLIST }

enum PlaybackType { ALBUM, PLAYLIST }

enum AppLanguage { AMHARIC, ENGLISH }

enum ArtistListDataType {
  USER_FAVORITE_ARTIST_LIST,
  ARTIST_LIST_FOR_ONBOARDING
}

enum LibraryFilter { song, album, artist, playlist }

enum PlaybackSrc { NETWORK, LOCAL }

enum PlaybackState { BUFFERING, PLAYING, PAUSED, IDLE }

enum DownloadStatus { PAUSED, COMPLETED, FAILED, IN_PROGRESS, NOT_STARTED }

enum DownloadType { ALBUM, PLAYLIST, SINGLE }

enum ArtistListType {
  ARTIST_HORIZONTAL_LIST,
  ARTIST_VERTICAL_LIST,
  ARTIST_GRID_LIST
}

enum SongTypeEnum { SINGLE, EP, ALBUM }

enum PlaylistFilter { TODAY, MONTH, LIKED }

enum ButtonType {
  ROUND_OUTLINED_BUTTON,
  ROUND_ELEVATED_BUTTON,
  NORMAL_OUTLINED_BUTTON,
  NORMAL_ELEVATED_BUTTON,
  TEXT_BUTTON
}
