import 'package:json_annotation/json_annotation.dart';
import 'package:zema/modals/library.dart';

part 'user.g.dart';

@JsonSerializable(explicitToJson: true)
class User {
  @JsonKey(name: "_id")
  String? id;

  String? username;
  String? email;
  // bool emailVerfied?: boolean

  // String password;
  // DateTime passwordChangedAt;
  // String passwordResetToken?: String
  // DateTime passwordTokenExpireDate?: Date

  // String token?: String

  String? phoneNumber;
  String? profileImagePath;

  List<String>? category;
  // List<String> musicGenre
  // List<String> tags;
  // bookGenre?: String[],
  // podcastCategory?: String[],
  // trialAccount : Boolean

  // trialPeriodEligable?: Boolean
  // subscription?: ISubscription

  RecentActivity? recent;
  // history?: String[] | ISong[];
  Library? library;

  // downloads?: IDownload
  //  facebookId?: String
  // fcmToken? : String[],

  User({
    this.id,
    this.username,
    this.email,
    this.category,
    this.phoneNumber,
    this.profileImagePath,
    this.recent,
    this.library,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RecentActivity {
  String? id;
  String? name;
  String? image;
  String? type;
  DateTime? date;

  RecentActivity({
    this.id,
    this.name,
    this.image,
    this.type,
    this.date,
  });

  factory RecentActivity.fromJson(Map<String, dynamic> json) =>
      _$RecentActivityFromJson(json);
  Map<String, dynamic> toJson() => _$RecentActivityToJson(this);
}
