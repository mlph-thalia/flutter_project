import 'package:flutter/material.dart';
import 'package:ebus/shared/widgets/center_app_bar.dart';
import '../../../domain/models/equipment.dart';
import '../../../presentation/equipment_list/view_model/equipment_requested_view_model.dart';

class EquipmentDetailView extends StatelessWidget {
  EquipmentDetailView(this.equipment, {super.key});

  final Equipment equipment;
  final requestViewModel = EquipmentRequestedListViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CenterAppBar(equipment.name, context),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              width: 200,
              height: 200,
              child: Image.network(
                equipment.imageUrl,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 10),
            ListTile(
              title: Text(
                'Description',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              subtitle: Text(
                equipment.description,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            ListTile(
              title: Text(
                'Specs',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              subtitle: Text(
                equipment.specs,
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
            ListTile(
              title: Text(
                'Code',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              subtitle: Text(
                equipment.code,
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
            const SizedBox(height: 16),
            if (equipment.isAssigned == true) ...[
              ElevatedButton(
                onPressed: () {
                  showRequestEquipmentDialog(context, equipment);
                },
                child: const Text('Request This Equipment'),
              ),
            ],
            if (equipment.isAssigned == true) ...[
              Text("Requested by: ",
                  style: Theme.of(context).textTheme.headlineSmall),
              Text(equipment.employeeName,
                  style: Theme.of(context).textTheme.bodyLarge),
              Text("Date Requested: ${equipment.date}",
                  style: Theme.of(context).textTheme.bodyLarge),
              Text("Purpose: ${equipment.purpose}",
                  style: Theme.of(context).textTheme.bodyLarge),
            ],
          ],
        ),
      ),
    );
  }

  void showRequestEquipmentDialog(BuildContext context, Equipment equipment) {
    final id = equipment.id;
    final nameController = TextEditingController();
    final employeeNameController = TextEditingController();
    final dateController = TextEditingController();
    final purposeController = TextEditingController();

    showDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: '',
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Request Equipment',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Form(
                  key: requestViewModel.equipmentRequestedFormkey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: employeeNameController,
                        decoration: const InputDecoration(
                          labelText: 'Requester Name',
                          isDense: true,
                        ),
                        validator: (value) {
                          if (value!.isEmpty || value.trim().isEmpty) {
                            return 'Please enter your name.';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: dateController,
                        decoration: const InputDecoration(
                          labelText: 'Date Requested (mm-dd-yyyy)',
                          isDense: true,
                        ),
                        validator: (value) {
                          if (value!.isEmpty || value.trim().isEmpty) {
                            return 'Please enter date today.';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: purposeController,
                        decoration: const InputDecoration(
                          labelText: 'Purpose',
                          isDense: true,
                        ),
                        validator: (value) {
                          if (value!.isEmpty || value.trim().isEmpty) {
                            return 'Please enter the purpose of the request.';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (requestViewModel.equipmentRequestedFormkey.currentState!
                    .validate()) {
                  final requestedEquipment = Equipment();
                  requestedEquipment.id = id;
                  requestedEquipment.name = nameController.text;
                  requestedEquipment.employeeName = employeeNameController.text;
                  requestedEquipment.date = dateController.text;
                  requestedEquipment.purpose = purposeController.text;
                  requestedEquipment.isAssigned = true;


                  Navigator.of(context).pop();
                }
              },
              child: const Text('Request'),
            ),
          ],
        );
      },
    );
  }
}