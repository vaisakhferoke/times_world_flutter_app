import 'package:flutter/services.dart' as rootBundle;
import 'package:get/get.dart';
import 'package:timesworld_filter_app/app/model/filter_master.dart';
import 'package:timesworld_filter_app/app/model/filter_model.dart';

class HomeController extends GetxController {
  RxList<Datum> data = <Datum>[].obs;
  RxList<SelectedFilterTypeMaster> selectedItemsdata =
      <SelectedFilterTypeMaster>[].obs;
  RxList<FilterTypeMaster> filtreMaster = <FilterTypeMaster>[
    FilterTypeMaster(
      id: 1,
      isSelected: true.obs,
      name: 'Nearest to Me',
      sName: '(default)',
    ),
    FilterTypeMaster(
      id: 2,
      isSelected: false.obs,
      name: 'Trending this Week',
      sName: '',
    ),
    FilterTypeMaster(
      id: 3,
      isSelected: false.obs,
      name: 'Newest Added',
      sName: '',
    ),
    FilterTypeMaster(
      id: 4,
      isSelected: false.obs,
      name: 'Alphabetical',
      sName: '',
    ),
  ].obs;

  final isSortItem = true.obs;
  @override
  void onInit() {
    super.onInit();
    readJsonData();
  }

  Future readJsonData() async {
    //read json file
    final jsondata =
        await rootBundle.rootBundle.loadString('assets/json/filter.json');
    //decode json data as list

    final response = filterTypeFromJson(jsondata);
    data.addAll(response.data);
  }

  @override
  void onClose() {}
}
