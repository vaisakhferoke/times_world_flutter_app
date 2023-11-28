import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timesworld_filter_app/app/modules/home/views/widgets/item_card.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: const Icon(
          Icons.keyboard_arrow_left,
          color: Colors.black,
          size: 40,
        ),
        elevation: 0,
        title: const Text(
          'Filter Options',
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
      ),
      floatingActionButton: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: const Color(0xff485152)),
        child: Text(
          'Show 0 results'.toUpperCase(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Obx(() => Wrap(
              runSpacing: 5,
              spacing: 5,
              children: controller.selectedItemsdata
                  .map(
                    (e) => Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(5)),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          InkWell(
                            onTap: () {
                              controller.selectedItemsdata.removeAt(
                                  controller.selectedItemsdata.indexOf(e));
                              final item = controller
                                  .data[e.index].taxonomies[e.itemIndex];
                              item.isSelected(false);
                            },
                            child: const Icon(
                              Icons.close,
                              size: 15,
                            ),
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          Text(
                            e.name,
                            style: const TextStyle(fontSize: 11),
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList())),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
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
                              const Text(
                                "Sort by",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  controller.isSortItem.value =
                                      !controller.isSortItem.value;
                                },
                                icon: Icon(
                                  controller.isSortItem.value
                                      ? Icons.keyboard_arrow_down
                                      : Icons.keyboard_arrow_up,
                                ),
                              )
                            ],
                          ),
                          if (controller.isSortItem.value)
                            ListView.separated(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              shrinkWrap: true,
                              physics: const ScrollPhysics(),
                              itemCount: controller.filtreMaster.length,
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                height: 15,
                              ),
                              itemBuilder: ((context, index) {
                                final filterItem =
                                    controller.filtreMaster[index];
                                return Obx(() => GestureDetector(
                                      onTap: () {
                                        for (var element
                                            in controller.filtreMaster) {
                                          element.isSelected.value = false;
                                        }

                                        filterItem.isSelected.value =
                                            !filterItem.isSelected.value;
                                      },
                                      child: Row(
                                        children: [
                                          filterItem.isSelected.value
                                              ? const SelectedCheckbox()
                                              : const UnSelectedCheckbox(),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Row(
                                            children: [
                                              Text(filterItem.name),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                filterItem.sName,
                                                style: const TextStyle(
                                                    color: Colors.grey),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ));
                              }),
                            )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Obx(
                    () => ListView.separated(
                      shrinkWrap: true,
                      itemCount: controller.data.length,
                      physics: const ScrollPhysics(),
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 10,
                      ),
                      itemBuilder: ((context, index) {
                        final filterItem = controller.data[index];
                        return ItemCard(
                          filterItem: filterItem,
                          masterIndex: index,
                          controller: controller,
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

class SelectedCheckbox extends StatelessWidget {
  const SelectedCheckbox({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: const Color(0xff702B44)),
      ),
      child: Center(
        child: Container(
          width: 10,
          height: 10,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xff702B44),
          ),
        ),
      ),
    );
  }
}

class UnSelectedCheckbox extends StatelessWidget {
  const UnSelectedCheckbox({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.grey,
        ),
      ),
      child: Center(
        child: Container(
          width: 10,
          height: 10,
          decoration:
              const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
        ),
      ),
    );
  }
}
