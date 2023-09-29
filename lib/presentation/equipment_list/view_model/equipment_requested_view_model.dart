import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../services/firebase/authentication.dart';
import '../../../services/firebase/firestore_services.dart';
import '../../../domain/models/equipment.dart';

class EquipmentRequestedListViewModel {
  final firebaseAuth = Authentication(FirebaseAuth.instance);
  final nameController = TextEditingController();
  final employeeNameController = TextEditingController();
  final dateController = TextEditingController();
  final purposeController = TextEditingController();
  final equipmentRequestedFormkey = GlobalKey<FormState>();

  List<Equipment> requestedEquipment = [];

  // Stream<QuerySnapshot> getRequestedEquipmentStream() {
  //   return FirebaseFirestore.instance
  //       .collection('equipment')
  //       .where('isAssigned', isEqualTo: true)
  //       .snapshots();
  // }


  Stream<QuerySnapshot> getRequestedEquipmentStream() {
    final stream = FirebaseFirestore.instance.collection('equipment').where('isAssigned', isEqualTo: true).snapshots();
    stream.listen((snapshot) {
      requestedEquipment = snapshot.docs.map((doc) {
        final equipment = Equipment();
        equipment.name = doc['name'];
        equipment.code = doc['code'];
        equipment.description = doc['description'];
        equipment.specs = doc['specs'];
        equipment.imageUrl = doc['imageUrl'];
        return equipment;
      }).toList();
    });
    return stream;
  }
}


  Stream<QuerySnapshot> getRequestedEquipmentStream() {
    return FirebaseFirestore.instance
        .collection('equipment')
        .where('isAssigned', isEqualTo: true)
        .snapshots();
  }


//
//   Future<void> requestEquipment(Equipment equipment) async {
//     final fireStoreService =
//     FireStoreServices(userUid: firebaseAuth.getCurrentUserUid() ?? '');
//     fireStoreService.requestEquipment(
//         equipment.id,
//         equipment.code,
//         equipment.name,
//         equipment.description,
//         equipment.specs,
//         equipment.imageUrl,
//         employeeNameController.text,
//         dateController.text,
//         purposeController.text);
//   }
// }