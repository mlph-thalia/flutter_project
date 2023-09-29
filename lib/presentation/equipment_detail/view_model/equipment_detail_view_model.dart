import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../services/firebase/authentication.dart';
import '../../../services/firebase/firestore_services.dart';
import '../../../domain/models/equipment.dart';

class EquipmentRequestedListViewModel {
  final firebaseAuth = Authentication(FirebaseAuth.instance);
  final employeeNameController = TextEditingController();
  final dateController = TextEditingController();
  final purposeController = TextEditingController();
  final equipmentRequestedFormkey = GlobalKey<FormState>();


  Future<void> requestEquipment(Equipment equipment) async {
    final fireStoreService =
    FireStoreServices(userUid: firebaseAuth.getCurrentUserUid() ?? '');
    fireStoreService.requestEquipment(
        equipment.id,
        equipment.code,
        equipment.name,
        equipment.description,
        equipment.specs,
        equipment.imageUrl,
        employeeNameController.text,
        dateController.text,
        purposeController.text);
  }
}