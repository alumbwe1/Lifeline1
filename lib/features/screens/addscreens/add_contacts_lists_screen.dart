import 'dart:io';

import 'package:flutter/material.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:image_picker/image_picker.dart';

class AddToContactLists extends StatefulWidget {
  const AddToContactLists({Key? key}) : super(key: key);

  @override
  _AddToContactListsState createState() => _AddToContactListsState();
}

class _AddToContactListsState extends State<AddToContactLists> {
  TextEditingController phoneNumberController = TextEditingController();
  ImagePicker _imagePicker = ImagePicker();
  XFile? _pickedImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade800,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Create your\nown Customs\nContacts',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: phoneNumberController,
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () async {
                  XFile? pickedImage = await _imagePicker.pickImage(source: ImageSource.gallery);
                  setState(() {
                    _pickedImage = pickedImage;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.white,
                      backgroundImage: _pickedImage != null ? FileImage(File(_pickedImage!.path)) : null,
                      child: _pickedImage == null
                          ? Icon(
                        Icons.camera_alt,
                        size: 40,
                        color: Colors.blue.shade800,
                      )
                          : null,
                    ),
                  ),
                ),
              ),
              TextField(
                controller: phoneNumberController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 10,),
              Container(
                height: 60,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.lightGreen,
                  borderRadius: BorderRadius.circular(9),
                ),
                child: const Center(child: Text('Save')),
              )
            ],
          ),
        ),
      ),
    );
  }
}
