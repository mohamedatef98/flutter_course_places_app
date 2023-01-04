import 'dart:io';

import 'package:flutter/material.dart';
import 'package:project_5/utils/image_picker.dart';

class ImageInput extends StatelessWidget {
  final void Function(File) onImagePick;
  final File? image;
  const ImageInput({
    super.key,
    required this.onImagePick,
    this.image
  });

  Widget renderStoredImage() {
    if(image != null) {
      return Image.file(image!);
    }
    else {
      return const Text(
        "No Picture Taken",
        textAlign: TextAlign.center,
      );
    }
  }

  void takePicture() {
    imagePicker().then((image) {
      if(image != null) {
        onImagePick(image);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey
            )
          ),
          alignment: Alignment.center,
          child: renderStoredImage(),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: TextButton.icon(
            onPressed: takePicture,
            icon: const Icon(Icons.camera),
            label: const Text("Take Picture"),
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Theme.of(context).colorScheme.primary)
            ),
          )
        )
      ],
    );
  }
}