import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

Future<File> imagePicker() async {
  final imagePicker = ImagePicker();
  final image = await imagePicker.pickImage(
    source: ImageSource.camera,
    maxWidth: 600,

  );
  assert(image != null);

  final appDocsDir = await getApplicationDocumentsDirectory();
  final copiedImagePath = '${appDocsDir.path}/${image!.name}';
  await image.saveTo(copiedImagePath);

  return File(copiedImagePath);
}
