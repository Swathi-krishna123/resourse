import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:resource_plus/constants/colors.dart';
import 'package:resource_plus/controller/appcontroller.dart';
import 'package:resource_plus/customWidgets/customWidgets.dart';

class Homepage extends StatelessWidget {
  Homepage({super.key});

  final Appcontroller controller = Get.put(Appcontroller());
  final TextEditingController _searchController = TextEditingController();
  FocusNode searchFocusNode = FocusNode();

  // Filter search results based on query
  void _filterSearchResults(String query) {
    if (query.isEmpty) {
      controller.filteredMedicalSearch.clear(); // Ensure list is empty
    } else {
      controller.filteredMedicalSearch.assignAll(
        controller.medicalSearch.where((item) {
          final name = (item['nm'] ?? '').toString().toLowerCase();
          return name.contains(query.toLowerCase());
        }).toList(),
      );
    }
    controller.filteredMedicalSearch.refresh();
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: Customwidgets().customAppbar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Search TextField
                Container(
                  height: 50,
                  child: TextFormField(
                    controller: _searchController,
                    focusNode: searchFocusNode,
                    onChanged: _filterSearchResults,
                    decoration: InputDecoration(
                      hintText: 'Search',
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 15,
                        color: Appcolors.hintColor,
                      ),
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: Container(
                        margin:
                            const EdgeInsets.only(right: 6, top: 6, bottom: 6),
                        width: 44,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: Appcolors.themeColor.withOpacity(0.14),
                        ),
                        child: Center(
                          child: SvgPicture.asset(
                            'assets/svg/searchPrefixicon.svg',
                            height: 20,
                          ),
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Appcolors.themeColor.withOpacity(0.44),
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Appcolors.themeColor),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Obx(
                  () => controller.selectedItems.isEmpty
                      ? SizedBox.shrink()
                      : Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              margin: const EdgeInsets.only(
                                  right: 10), // Add margin between items
                              decoration: BoxDecoration(
                                color: Appcolors.themeColor.withOpacity(0.14),
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(color: Appcolors.themeColor),
                              ),
                              child: Text(
                                'Refresh',
                                style: TextStyle(
                                  color: Appcolors.blackColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              margin: const EdgeInsets.only(
                                  right: 10), // Add margin between items
                              decoration: BoxDecoration(
                                color: Appcolors.themeColor.withOpacity(0.14),
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(color: Appcolors.themeColor),
                              ),
                              child: Text(
                                'Share Resources',
                                style: TextStyle(
                                  color: Appcolors.blackColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                ),
                SizedBox(
                  height: 20,
                ),

                // Selected Items Display
                // Selected Items Display
                Obx(() {
                  if (controller.selectedItems.isEmpty) {
                    return const SizedBox
                        .shrink(); // No display if no items selected
                  }
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal, // Scroll horizontally
                    child: Row(
                      children: controller.selectedItems.map((item) {
                        final name = item['nm'] ?? 'Unknown Name';
                        return Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          margin: const EdgeInsets.only(
                              right: 10), // Add margin between items
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(color: Appcolors.blackColor),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                name,
                                style: TextStyle(
                                  color: Appcolors.blackColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(width: 5),
                              GestureDetector(
                                onTap: () {
                                  // Remove the item when delete icon is clicked
                                  controller.selectedItems.remove(item);
                                  controller.selectedItems.refresh();
                                },
                                child: const Icon(
                                  Icons.close,
                                  color: Colors.red,
                                  size: 18,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  );
                }),
              ],
            ),
          ),

          // List or Placeholder
          Expanded(
            child: Obx(() {
              if (controller.filteredMedicalSearch.isEmpty) {
                // Placeholder shown when no search results
                return Center(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Stack(
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: SvgPicture.asset(
                                  'assets/svg/backgroundimg.svg'),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child:
                                  SvgPicture.asset('assets/svg/bgobjects.svg'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Search by keyword or select\ntopics from the list below',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Appcolors.hintColor,
                            fontWeight: FontWeight.w400,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }

              // Show filtered search results
              return ListView.builder(
                shrinkWrap: true,
                itemCount: controller.filteredMedicalSearch.length,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  final item = controller.filteredMedicalSearch[index];
                  final name = item['nm'] ?? 'Unknown Name';

                  return Obx(() {
                    // Check if the current item is selected
                    final isSelected = controller.selectedItems.any(
                      (selectedItem) => selectedItem['id'] == item['id'],
                    );

                    return CheckboxListTile(
                      title: Text(name),
                      value: isSelected,
                      onChanged: (bool? value) {
                        if (value == true) {
                          // Add the item if it is not already selected
                          controller.selectedItems.add(item);
                        } else {
                          // Remove the item if it is already selected
                          controller.selectedItems.removeWhere(
                            (selectedItem) => selectedItem['id'] == item['id'],
                          );
                        }

                        // Log the current selection for debugging
                        log("Selected items: ${controller.selectedItems.map((e) => e['id'])}");

                        // Notify the UI of changes
                        controller.selectedItems.refresh();
                      },
                    );
                  });
                },
              );
            }),
          ),

          // Conditional Button at the Bottom
          Obx(() {
            return Visibility(
              visible: controller.selectedItems.isNotEmpty,
              child: Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Appcolors.themeColor.withOpacity(0.14),
                ),
                child: GestureDetector(
                  onTap: () {
                    // Log selected items (already being shown in the box)
                    log("Proceed with selected items: ${controller.selectedItems}");
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.search,
                        color: Appcolors.themeColor,
                        size: 30,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        'Find Resources',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: Appcolors.themeColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
