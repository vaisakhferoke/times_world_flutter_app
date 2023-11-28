import 'package:get/get.dart';

class FilterTypeMaster {
  int id;
  String name;
  String sName;
  RxBool isSelected;

  FilterTypeMaster({
    required this.id,
    required this.name,
    required this.sName,
    required this.isSelected,
  });

  factory FilterTypeMaster.fromJson(Map<String, dynamic> json) =>
      FilterTypeMaster(
        id: json["id"],
        name: json["name"],
        sName: json["s_name"],
        isSelected: json["is_selected"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "s_name": sName,
        "is_selected": isSelected,
      };
}

class SelectedFilterTypeMaster {
  int index;
  int itemIndex;
  String name;

  SelectedFilterTypeMaster({
    required this.index,
    required this.itemIndex,
    required this.name,
  });

  factory SelectedFilterTypeMaster.fromJson(Map<String, dynamic> json) =>
      SelectedFilterTypeMaster(
        index: 0,
        name: json["name"],
        itemIndex: 0,
      );
}
