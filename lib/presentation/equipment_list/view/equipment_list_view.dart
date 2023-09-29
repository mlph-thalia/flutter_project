import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebus/domain/models/equipment.dart';
import 'package:ebus/shared/widgets/center_app_bar.dart';
import 'package:ebus/shared/widgets/custom_dialog.dart';
import 'package:ebus/shared/widgets/custom_textfield.dart';
import '../../equipment_detail/view/equipment_detail_view.dart';
import '../view_model/equipment_list_view_model.dart';
import '../view_model/equipment_requested_view_model.dart';

class EquipmentListView extends StatefulWidget {
  EquipmentListView({super.key});

  @override
  _EquipmentListViewState createState() => _EquipmentListViewState();
}

class _EquipmentListViewState extends State<EquipmentListView> {
  final viewModel = EquipmentListViewModel();
  final requestViewModel = EquipmentRequestedListViewModel();

  final List<BottomNavigationBarItem> bottomNavBarItems = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Equipment List',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.list),
      label: 'Requested Equipment',
    ),
  ];

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CenterAppBar(
        selectedIndex == 0 ? 'Available Equipment' : 'Requested Equipment',
        context,
        shouldShowLeading: false,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: bottomNavBarItems,
        currentIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  StreamBuilder<QuerySnapshot>(
                    stream: selectedIndex == 0
                        ? viewModel.getEquipmentStream()
                        : requestViewModel.getRequestedEquipmentStream(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return const Text('Something went wrong');
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
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

                              return Padding(
                                padding: const EdgeInsets.only(bottom: 0),
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
