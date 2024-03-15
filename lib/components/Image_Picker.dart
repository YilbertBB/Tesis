import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class Image_Picker extends StatefulWidget {
  const Image_Picker({super.key});

  @override
  State<Image_Picker> createState() => _Image_PickerState();
}

class _Image_PickerState extends State<Image_Picker> {
  File? _image;

  Future _pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      final img = File(image.path);
      setState(() {
        _image = img;
        Navigator.pop(context);
      });
    } on PlatformException catch (e) {
      print('Fallo al cagar la imagen: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showPickerOptions(context);
      },
      child: _image != null
          ? ClipOval(
              child: Image.file(
                _image!,
                width: 110,
                height: 110,
                fit: BoxFit.cover,
              ),
            )
          : Stack(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(width: 5, color: Colors.white),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 20,
                        offset: Offset(5, 5),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.person,
                    color: Colors.grey.shade300,
                    size: 80.0,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(80, 80, 0, 0),
                  child: Icon(
                    Icons.add_circle,
                    color: Colors.grey.shade700,
                    size: 25.0,
                  ),
                ),
              ],
            ),
    );
  }

  void _showPickerOptions(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Camara'),
              onTap: () {
                _pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.image),
              title: const Text('Galeria'),
              onTap: () {
                _pickImage(ImageSource.gallery);
              },
            ),
          ],
        );
      },
    );
  }
}
