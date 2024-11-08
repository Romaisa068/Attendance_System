import 'package:attend_system/FirebaseAuth/firebase_services.dart';
import 'package:attend_system/constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ViewData extends StatefulWidget {
  const ViewData({super.key});

  @override
  State<ViewData> createState() => _ViewDataState();
}

class _ViewDataState extends State<ViewData> {
  Map<String, dynamic>? dataList;

  Future<void> loadData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      print(
          'Fetching latest data for user: ${user.uid}'); // Debugging statement
      Map<String, dynamic>? data = await FirebaseServices().getData(user.uid);

      setState(() {
        dataList = data;
      });
    } else {
      print('No user signed in'); // Debugging statement
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: const Text(
          'User Latest Attendance Data',
          style: KtextStyle,
        ),
      ),
      body: dataList == null
          ? const Center(child: CircularProgressIndicator())
          : Center(
              child: Container(
                constraints: const BoxConstraints(
                  minWidth: 100,
                  maxWidth: 300,
                  minHeight: 100,
                  maxHeight: 200,
                ),
                child: Card(
                  color: Colors.blue,
                  elevation: 4.0,
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Name: ${dataList?['name'] ?? 'N/A'}', // Added null safety check
                          style: KtextStyle,
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        Text(
                          'Attendance: ${dataList?['attendanceNumber'] ?? 'N/A'}',
                          style: KtextStyle.copyWith(fontSize: 16.0),
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        Text(
                          'Status: ${dataList?['status'] ?? 'N/A'}',
                          style: KtextStyle.copyWith(fontSize: 16.0),
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        Text(
                          'Date: ${(dataList?['date'] != null) ? dataList!['date'].toDate().toLocal().toString() : 'N/A'}',
                          style: KtextStyle.copyWith(fontSize: 16.0),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
