import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timesworld_filter_app/app/model/filter_master.dart';
import 'package:timesworld_filter_app/app/model/filter_model.dart';
import 'package:timesworld_filter_app/app/modules/home/controllers/home_controller.dart';
import 'package:timesworld_filter_app/app/modules/home/views/home_view.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({
    Key? key,
    required this.filterItem,
    required this.masterIndex,
    required this.controller,
  }) : super(key: key);

  final Datum filterItem;
  final int masterIndex;
  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Obx(
          () => Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        filterItem.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      if (filterItem.taxonomies
                          .where((element) => element.isSelected.value == true)
                          .toList()
                          .isNotEmpty)
                        Text(
                          '  (${filterItem.taxonomies.where((element) => element.isSelected.value == true).toList().length.toString()})',
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff702B44)),
                        ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {
                      filterItem.isSelected.value =
                          !filterItem.isSelected.value;
                    },
                    icon: Icon(
                      filterItem.isSelected.value
                          ? Icons.keyboard_arrow_down
                          : Icons.keyboard_arrow_up,
                    ),
                  )
                ],
              ),
              if (filterItem.isSelected.value)
                ListView.separated(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  shrinkWrap: true,
                  itemCount: filterItem.taxonomies.length,
                  physics: const ScrollPhysics(),
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 15,
                  ),
                  itemBuilder: ((context, index) {
                    final item = filterItem.taxonomies[index];
                    return GestureDetector(
                        onTap: () {
                          item.isSelected.value = !item.isSelected.value;
                          if (item.isSelected.value) {
                            controller.selectedItemsdata.add(
                                SelectedFilterTypeMaster(
                                    index: masterIndex,
                                    itemIndex: index,
                                    name: item.name ?? ''));
                          } else {
                            controller.selectedItemsdata.removeWhere(
                                (element) =>
                                    element.index == masterIndex &&
                                    element.itemIndex == index);
                          }
                        },
                        child: Obx(
                          () => Row(
                            children: [
                              item.isSelected.value
                                  ? const SelectedCheckbox()
                                  : const UnSelectedCheckbox(),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(item.name ?? ''),
                            ],
                          ),
                        ));
                  }),
                )
            ],
          ),
        ));
  }
}
