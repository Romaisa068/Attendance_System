import 'dart:io';
import 'package:attend_system/FirebaseAuth/firebase_services.dart';
import 'package:attend_system/UserPanel/view_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:attend_system/constant.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  static const String id = 'User_Screen';

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  File? _imageFile;
  bool isAttendanceMark = false;

  Future<void> pickimage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  void markAttendance() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseServices().markAttendance(user.uid);
      setState(() {
        isAttendanceMark = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Attendance marked successfully.'),
        ),
      );
    } else {
      print('No user is logged in');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: const Text(
          "Attendance System",
          style: KtextStyle,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Stack(
              children: [
                CircleAvatar(
                  radius: 60.0,
                  backgroundImage: _imageFile != null
                      ? FileImage(_imageFile!)
                      : const AssetImage('images/download.jpeg')
                          as ImageProvider,
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: InkWell(
                    onTap: pickimage,
                    child: const CircleAvatar(
                      radius: 20.0,
                      backgroundColor: Colors.lightBlueAccent,
                      child: Icon(
                        Icons.edit,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 46.0,
          ),
          ElevatedButton(
            onPressed: isAttendanceMark ? null : markAttendance,
            style: ElevatedButton.styleFrom(
                elevation: 8.0, backgroundColor: Colors.lightBlueAccent),
            child: Text(
              isAttendanceMark ? 'Attendance Marked' : 'Mark Attendance',
              style: KButtonTextStyle.copyWith(fontSize: 16.0),
            ),
          ),
          const SizedBox(
            height: 16.0,
          ),
          ElevatedButton(
            onPressed: () {
              final user = FirebaseAuth.instance.currentUser;
              if (user != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ViewData(),
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightBlueAccent),
            child: Text(
              'View Attendance',
              style: KButtonTextStyle.copyWith(fontSize: 16.0),
            ),
          ),
        ],
      ),
    );
  }
}
