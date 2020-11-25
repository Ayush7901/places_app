import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

class ImageInput extends StatefulWidget {
  final Function onSaveImage;
  ImageInput(this.onSaveImage);
  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File _storedImage;
  Future<void> _takePicture() async {
    final picker = ImagePicker();
    final imageFile = await picker.getImage(
      source: ImageSource.camera,
      maxWidth: 800,
    );
   setState(() {
      _storedImage = File(imageFile.path);
    });
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile.path);
    final savedImage = await File(imageFile.path).copy('${appDir.path}/$fileName');
    widget.onSaveImage(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
          ),
          height: 100,
          width: 100,
          child: _storedImage != null
              ? Image.file(_storedImage)
              : Text(
                  'No Image Taken',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                  textAlign: TextAlign.center,
                ),
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: RaisedButton.icon(
            onPressed: _takePicture,
            icon: Icon(Icons.camera),
            label: Text(
              'Add Image',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
