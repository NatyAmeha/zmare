import 'package:json_annotation/json_annotation.dart';
import 'package:zmare/modals/artist.dart';

@JsonSerializable(explicitToJson: true)
class Preview {
  @JsonKey(name: "_id")
  String? id;
  String? title;
  String? description;
  List<String>? images;
  String? artistId;
  String? artistName;
  String? artistImage;
  String? audioFile;
  String? destinationId;

  Preview(
      {this.id,
      this.title,
      this.description,
      this.images,
      this.artistId,
      this.artistName,
      this.artistImage,
      this.audioFile,
      this.destinationId});
}
