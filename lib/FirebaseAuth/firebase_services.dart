import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User?> signUpwithEmailPassword(
      String email, String password, String username) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = credential.user;

      if (user != null) {
        await saveUser(user, username);
      }
      return user;
    } catch (e) {
      print('Error while creating user $e');
      return null;
    }
  }

  Future<User?> signInwithEmailPassword(String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = credential.user;
      return user;
    } catch (e) {
      print('Error while signing in $e');
      return null;
    }
  }

  Future<void> saveUser(User user, String name) async {
    try {
      await _firestore.collection('users').doc(user.uid).set({
        'user_name': name,
        'user_id': user.uid,
        'user_email': user.email,
      }, SetOptions(merge: true)); //
      print('User saved successfully!');
    } catch (e) {
      print('Error while saving user $e');
    }
  }

  Future<void> markAttendance(String userid) async {
    try {
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(userid).get();

      if (userDoc.exists) {
        String username = userDoc['user_name'];
        print('User found: $username');

        DateTime today = DateTime.now();
        String todayDate = '${today.year}-${today.month}-${today.day}';

        QuerySnapshot attendanceSnapshot = await _firestore
            .collection('users')
            .doc(userid)
            .collection('attendance')
            .where('date', isGreaterThanOrEqualTo: todayDate)
            .where('date', isLessThanOrEqualTo: todayDate)
            .get();

        if (attendanceSnapshot.docs.isNotEmpty) {
          print('Attendance already marked for today');
          return; // Exit early to prevent multiple marks for the same day
        }

        int count = attendanceSnapshot.docs.length + 1;

        await _firestore
            .collection('users')
            .doc(userid)
            .collection('attendance')
            .add({
          'name': username,
          'attendanceNumber': count,
          'date': FieldValue.serverTimestamp(),
          'status': 'present',
        });

        print('Attendance marked successfully');
      } else {
        print('user not found');
      }
    } catch (e) {
      print('Error while marking attendance $e');
    }
  }

  Future<Map<String, dynamic>?> getData(String userid) async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('users')
          .doc(userid)
          .collection('attendance')
          .orderBy('date', descending: true)
          .limit(1)
          .get();

      if (snapshot.docs.isNotEmpty) {
        return snapshot.docs.first.data() as Map<String, dynamic>;
      } else {
        return null;
      }
    } catch (e) {
      print('Error fetching attendance: $e');
    }
    return null;
  }
}
