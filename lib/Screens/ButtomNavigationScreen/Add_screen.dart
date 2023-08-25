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
  TextEditingController _dateController = TextEditingController();
  TextEditingController _locationController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();

  File? _selectedImage;

  void _submitCatData() async {
    String name = _nameController.text;
    double price = _priceController.text.isNotEmpty ? double.parse(_priceController.text) : 0;
    String date = _dateController.text;
    String location = _locationController.text;
    String phoneNumber = _phoneController.text;

    if (name.isNotEmpty && date.isNotEmpty && location.isNotEmpty && _selectedImage != null) {
      String imageFileName = DateTime.now().millisecondsSinceEpoch.toString();
      final firebase_storage.Reference storageReference =
      firebase_storage.FirebaseStorage.instance.ref().child(imageFileName);
      await storageReference.putFile(_selectedImage!);
      String imageUrl = await storageReference.getDownloadURL();

      FirebaseFirestore.instance.collection('cats').add({
        'name': name,
        'price': price,
        'image': imageUrl,
        'publicationDate': date,
        'location': location,
        'phoneNumber': phoneNumber,
      });

      _nameController.clear();
      _priceController.clear();
      _dateController.clear();
      _locationController.clear();
      _phoneController.clear();

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

  void _pickImageFromGallery() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
      });
    }
  }

  void _pickImageFromCamera() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(source: ImageSource.camera);

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
      //   title: Text('Add Cat Data'),
      // ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              Card(
                elevation: 3,
                child: TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    contentPadding: EdgeInsets.all(5),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Card(
                elevation: 3,
                child: TextField(
                  controller: _priceController,
                  decoration: InputDecoration(
                    labelText: 'Price',
                    contentPadding: EdgeInsets.all(5),
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              SizedBox(height: 10),
              Card(
                elevation: 3,
                child: TextField(
                  controller: _dateController,
                  decoration: InputDecoration(
                    labelText: 'Publication Date',
                    contentPadding: EdgeInsets.all(5),
                  ),
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101),
                    );

                    if (pickedDate != null) {
                      setState(() {
                        _dateController.text = pickedDate.toLocal().toString();
                      });
                    }
                  },
                ),
              ),
              SizedBox(height: 10),
              Card(
                elevation: 3,
                child: TextField(
                  controller: _locationController,
                  decoration: InputDecoration(
                    labelText: 'Location',
                    contentPadding: EdgeInsets.all(5),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Card(
                elevation: 3,
                child: TextField(
                  controller: _phoneController,
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    contentPadding: EdgeInsets.all(5),
                  ),
                  keyboardType: TextInputType.phone,
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _pickImageFromGallery,
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  onPrimary: Colors.white,
                ),
                child: Text('Pick Image from Gallery'),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: _pickImageFromCamera,
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  onPrimary: Colors.white,
                ),
                child: Text('Capture Image from Camera'),
              ),
              SizedBox(height: 20),
              Container(
                height: 100,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: _selectedImage != null
                    ? Image.file(_selectedImage!)
                    : Center(child: Text('No image selected')),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitCatData,
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  onPrimary: Colors.white,
                ),
                child: Text('Publish'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
