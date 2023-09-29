import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../domain/models/equipment.dart';
import '../../../services/firebase/authentication.dart';
import '../../../services/firebase/firestore_services.dart';

class EquipmentListViewModel {
  final firebaseAuth = Authentication(FirebaseAuth.instance);
  final codeController = TextEditingController();
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final specsController = TextEditingController();
  final imageController = TextEditingController();
  final equipmentFormkey = GlobalKey<FormState>();

  List<Equipment> availableEquipment = [];


  Stream<QuerySnapshot> getEquipmentStream() {
    final stream = FirebaseFirestore.instance.collection('equipment').where('isAssigned', isEqualTo: false).snapshots();
    stream.listen((snapshot) {
      availableEquipment = snapshot.docs.map((doc) {
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

//   Stream<QuerySnapshot> getEquipmentStream() {
//     return FirebaseFirestore.instance
//         .collection('equipment')
//         .where('isAssigned', isEqualTo: false)
//         .snapshots();
//   }
// }