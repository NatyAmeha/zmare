import 'package:json_annotation/json_annotation.dart';
part 'fb_auth.g.dart';

@JsonSerializable(explicitToJson: true)
class FBAuth {
  String? token;
  bool? isNewUser;

  FBAuth({this.token, this.isNewUser});

  factory FBAuth.fromJson(Map<String, dynamic> json) => _$FBAuthFromJson(json);
  Map<String, dynamic> toJson() => _$FBAuthToJson(this);
}
