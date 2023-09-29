import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class FireStoreServices {
  FireStoreServices({required this.userUid});

  final String userUid;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addEquipment(String code, String name, String description,
      String specs, String imageUrl) async {
    final Map<String, dynamic> data = <String, dynamic>{
      'code': code,
      'name': name,
      'description': description,
      'specs': specs,
      'imageUrl': imageUrl,
      'employeeName': '',
      'date': '',
      'purpose': '',
      'isAssigned': false
    };

    final DocumentReference documentReferencer =
        _firestore.collection('equipment').doc();

    await documentReferencer.set(data).whenComplete(() {
      if (kDebugMode) {
        print('equipment added to the database');
      }
    }).catchError((e) {
      if (kDebugMode) {
        print('Error: $e');
      }
    });
  }

  Future<void> requestEquipment(
      String id,
      String code,
      String name,
      String description,
      String specs,
      String imageUrl,
      String employeeName,
      String date,
      String purpose) async {
    final Map<String, dynamic> data = <String, dynamic>{
      'code': code,
      'name': name,
      'description': description,
      'specs': specs,
      'imageUrl': imageUrl,
      'employeeName': employeeName,
      'date': date,
      'purpose': purpose,
      'isAssigned': true
    };

    final DocumentReference documentReferencer =
        _firestore.collection('equipment').doc(id);

    await documentReferencer.update(data).whenComplete(() {
      if (kDebugMode) {
        print('your request has been updated to the database');
      }
    }).catchError((e) {
      if (kDebugMode) {
        print('Error: $e');
      }
    });
  }
}
