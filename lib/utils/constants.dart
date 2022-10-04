class Constants {
  // preference constants
  static const REGISTERED = "REGISTEREND";
  static const LOGGED_IN = "LOGGED_IN";

  static const USER_ID = "USER_ID";
  static const TOKEN = "TOKEN";
  static const USERNAME = "USER_NAME";
  static const PHONE_NUMBER = "PHONE_NUMBER";
  static const PROFILE_IMAGE = "PROFILE_IMAGE";
}

enum AlbumListType { ALBUM_GRID_LIST, ALBUM_HORIZONTAL_LIST }

enum PlaylistListType { HORIZONTAL, GRID }

enum AudioSrcType { NETWORK, LOCAL_STORAGE, DOWNLOAD }

enum AlbumListDataType { USER_FAVORITE_ALBUM_LIST }

enum ArtistListDataType { USER_FAVORITE_ARTIST_LIST }

enum LibraryFilter { song, album, artist, playlist }

enum PlaybackSrc { NETWORK, LOCAL }

enum PlaybackState { BUFFERING, PLAYING, PAUSED, IDLE }

enum ArtistListType {
  ARTIST_HORIZONTAL_LIST,
  ARTIST_VERTICAL_LIST,
  ARTIST_GRID_LIST
}

enum SongTypeEnum { SINGLE, EP, ALBUM }

enum PlaylistFilter { TODAY, MONTH, LIKED }

enum DownloadStatus {
  DOWNLOAD_COMPLETED,
  DOWNLOAD_PAUSED,
  DOWNLOAD_NOT_STARTED,
  DOWNLOAD_IN_PROGRESS
}

enum ButtonType {
  ROUND_OUTLINED_BUTTON,
  ROUND_ELEVATED_BUTTON,
  NORMAL_OUTLINED_BUTTON,
  NORMAL_ELEVATED_BUTTON,
  TEXT_BUTTON
}
