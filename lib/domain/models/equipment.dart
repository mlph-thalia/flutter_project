class Equipment {
  String id = '';
  String name = '';
  String code = '';
  String description = '';
  String specs = '';
  String imageUrl = '';
  String employeeName = '';
  String date = '';
  String purpose = '';
  bool isAssigned = true;

  // Getter for employeeName


  String get getId => id;

  set setId (String value) {
    id = value;
  }
}
