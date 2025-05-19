import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  const UserImagePicker({super.key});

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? _pickedImageFile;

  void _pickImage(ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
      maxWidth: 150,
    );

    if (pickedImage == null) {
      return;
    }

    setState(() {
      _pickedImageFile = File(pickedImage.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey,
          foregroundImage:
              _pickedImageFile != null ? FileImage(_pickedImageFile!) : null,
        ),
        TextButton.icon(
          onPressed: _takePicture,
          icon: Icon(Icons.image),
          label: Text(
            'Add Image',
            style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
          ),
        ),
      ],
    );
  }

  void _takePicture() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).primaryColorLight,
        title: const Text('Choose Image Source'),
        actions: [
          Container(
            height: 80,
            width: 100,
            decoration: BoxDecoration(
              border: Border.all(
                width: 2,
                color:
                    Theme.of(context).colorScheme.inverseSurface.withAlpha(128),
              ),
            ),
            child: TextButton.icon(
              onPressed: () {
                _pickImage(ImageSource.camera);
                Navigator.pop(context);
              },
              label:
                  const Text('Camera', style: TextStyle(color: Colors.black)),
              icon: const Icon(Icons.camera_alt, color: Colors.black),
            ),
          ),
          Container(
            height: 80,
            width: 100,
            decoration: BoxDecoration(
              border: Border.all(
                width: 2,
                color:
                    Theme.of(context).colorScheme.inverseSurface.withAlpha(128),
              ),
            ),
            child: TextButton.icon(
              onPressed: () {
                _pickImage(ImageSource.gallery);
                Navigator.pop(context);
              },
              label:
                  const Text('Gallery', style: TextStyle(color: Colors.black)),
              icon: const Icon(Icons.filter, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
