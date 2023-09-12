// Dart imports:
import 'dart:io';

class AddStoryModal {
  String? storeId;
  String? type;
  String? title;
  File? thumbnail;
  File? videoImage;
  String? storyUrl;
  AddStoryModal(
      {required this.thumbnail,
        required this.storeId,
      required this.storyUrl,
      required this.title,
      required this.type,
      required this.videoImage});
}
