import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../domain/models/equipment.dart';
import '../../../shared/widgets/center_app_bar.dart';
import '../../equipment_detail/view/equipment_detail_view.dart';
import '../view_model/equipment_requested_view_model.dart';
import '../../../shared/widgets/custom_dialog.dart';
import '../../../shared/widgets/custom_textfield.dart';

class EquipmentRequestedListView extends StatelessWidget {
  EquipmentRequestedListView({super.key});

  final requestViewModel = EquipmentRequestedListViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CenterAppBar(
        'Request Equipment',
        context,
        shouldShowLeading: false,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  StreamBuilder<QuerySnapshot>(
                    stream: requestViewModel.getRequestedEquipmentStream(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text('Something went wrong');
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasData) {
                        final data = snapshot.requireData;
                        return Expanded(
                          child: ListView.builder(
                            itemCount: data.size,
                            itemBuilder: (context, index) {
                              final equipment = Equipment();
                              equipment.id = data.docs[index].id;
                              equipment.name = data.docs[index]['name'];
                              equipment.code = data.docs[index]['code'];
                              equipment.description =
                              data.docs[index]['description'];
                              equipment.specs = data.docs[index]['specs'];
                              equipment.imageUrl = data.docs[index]['imageUrl'];
                              equipment.employeeName = data.docs[index]['employee name'];

                              return Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: ListTile(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            EquipmentDetailView(equipment),
                                      ),
                                    );
                                  },
                                  leading: Image.network(equipment.imageUrl),
                                  title: Text(equipment.name),
                                  subtitle: Text(equipment.specs),
                                  trailing: Text(equipment.description),
                                ),
                              );
                            },
                          ),
                        );
                      }
                      return Container();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
