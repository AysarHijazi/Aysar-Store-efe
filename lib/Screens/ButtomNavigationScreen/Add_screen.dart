import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'dart:io';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // title: 'Cat App',
      // theme: ThemeData(
      //   primarySwatch: Colors.blue,
      // ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  File? _selectedImage; // Holds the selected image file

  void _submitCatData() async {
    String name = _nameController.text;
    double price = double.parse(_priceController.text);

    if (name.isNotEmpty && price > 0 && _selectedImage != null) {
      // Upload image to Firebase Storage
      String imageFileName = DateTime.now().millisecondsSinceEpoch.toString();
      final firebase_storage.Reference storageReference =
      firebase_storage.FirebaseStorage.instance.ref().child(imageFileName);
      await storageReference.putFile(_selectedImage!);
      String imageUrl = await storageReference.getDownloadURL();

      // Save cat data to Firestore
      FirebaseFirestore.instance.collection('cats').add({
        'name': name,
        'price': price,
        'image': imageUrl,
      });

      // Clear input fields and selected image
      _nameController.clear();
      _priceController.clear();
      setState(() {
        _selectedImage = null;
      });

      // Show success message or navigate to a new screen
      // ...
    } else {
      // Show error message or validation feedback
      // ...
    }
  }

  void _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Cat App'),
      // ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _priceController,
              decoration: InputDecoration(labelText: 'Price'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickImage,
              child: Text('Pick Image'),
            ),
            SizedBox(height: 20),
            _selectedImage != null
                ? Image.file(
              _selectedImage!,
              height: 100,
            )
                : Container(),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitCatData,
              child: Text('Publish'),
            ),
          ],
        ),
      ),
    );
  }
}
