import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:project_5/utils/imagePicker.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({super.key});

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _storedImage;
  Widget renderStoredImage() {
    if(_storedImage != null) {
      return Image.file(_storedImage!);
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
      setState(() {
        _storedImage = image;
      });
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