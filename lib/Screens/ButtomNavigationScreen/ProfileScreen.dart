import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final ImagePicker _imagePicker = ImagePicker();

  User? _user;
  String _userName = 'اسم المستخدم';
  String _email = 'example@email.com';
  String _imageUrl = 'assets/images/profile_image.jpg';

  @override
  void initState() {
    super.initState();
    _getUserData();
  }

  Future<void> _getUserData() async {
    _user = _auth.currentUser;
    if (_user != null) {
      _userName = _user!.displayName ?? _userName;
      _email = _user!.email ?? _email;
      String? imageUrl = await _storage.ref('profile_images/${_user!.uid}').getDownloadURL().catchError((error) {
        print('Error getting profile image URL: $error');
      });
      if (imageUrl != null) {
        setState(() {
          _imageUrl = imageUrl;
        });
      }
    }
  }

  Future<void> _pickImage() async {
    final pickedImage = await _imagePicker.getImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      Reference storageReference = _storage.ref().child('profile_images/${_user!.uid}');
      UploadTask uploadTask = storageReference.putFile(File(pickedImage.path));
      await uploadTask.whenComplete(() => print('Image uploaded'));
      String imageUrl = await storageReference.getDownloadURL();
      setState(() {
        _imageUrl = imageUrl;
      });
    }
  }

  Future<void> _signOut() async {
    await _auth.signOut();
    Navigator.of(context).pop(); // Close the profile screen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('الملف الشخصي'),
      // ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(_imageUrl),
              ),
            ),
            SizedBox(height: 20),
            Text(
              _userName,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              _email,
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _signOut,
              child: Text('تسجيل الخروج'),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ProfileScreen(),
  ));
}
