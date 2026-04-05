import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class UploadStorageScreen extends StatefulWidget {
  const UploadStorageScreen .screen({super.key});

  @override
  State<UploadStorageScreen> createState() => _UploadStorageScreenState();
}

String? imgUrl;
//refrance (Storage)
final storageRef = FirebaseStorage.instance.ref();

class _UploadStorageScreenState extends State<UploadStorageScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold (
      appBar: AppBar(title: Text('Storage')),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            imgUrl != null
                ? Image.network(imgUrl!)
                : Container(color: Colors.amber, width: 50, height: 50),

            ElevatedButton(
              onPressed: () async {
                imgUrl = await storageRef
                    .child('images/1000056885.jpg')
                    .getDownloadURL();

                setState(() {});
              },
              // onPressed: () async {
              //   final ImagePicker imagePicker = ImagePicker();
              //   final img = await imagePicker.pickImage(
              //     source: ImageSource.gallery,
              //   );
              // if (img == null) return;

              // final file = File(img.path);

              // final fileName = DateTime.now().millisecondsSinceEpoch
              //     .toString();

              // final uploadRef = imagesRef.child("$fileName.png");

              // await uploadRef.putFile(file);

              // ScaffoldMessenger.of(
              //   context,
              // ).showSnackBar(const SnackBar(content: Text("Image uploaded")));
              //   if (img == null) return;
              //   final folderRef = storageRef.child('images/${img.name}');
              //   folderRef.putFile(File(img.path));

              //   ScaffoldMessenger.of(
              //     context,
              //   ).showSnackBar(const SnackBar(content: Text("Image uploaded")));
              // },
              child: Text('Get image'),
            ),
          ],
        ),
      ),
      
    );
  }
}

