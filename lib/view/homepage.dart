import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:resource_plus/constants/colors.dart';
import 'package:resource_plus/controller/appcontroller.dart';
import 'package:resource_plus/customWidgets/customWidgets.dart';
import 'package:resource_plus/view/shareResources.dart';

class Homepage extends StatelessWidget {
  Homepage({super.key});

  final Appcontroller controller = Get.put(Appcontroller());
  final TextEditingController _searchController = TextEditingController();
  FocusNode searchFocusNode = FocusNode();
  var searchboxEnable = false.obs;

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
                SizedBox(
                  height: 50,
                  child: TextFormField(
                    onTap: () {
                      searchboxEnable.value = true;
                    },
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
                const SizedBox(height: 5),
                Obx(
                  () => controller.selectedItems.isEmpty
                      ? const SizedBox.shrink()
                      : Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    controller.medicalSearchDetails.refresh();
                                  },
                                  child: Container(
                                    height: 42,
                                    width: 113,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    margin: const EdgeInsets.only(
                                        right: 10), // Add margin between items
                                    decoration: BoxDecoration(
                                      color: const Color(0xffD6C2FF)
                                          .withOpacity(0.14),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                            'assets/svg/refreshicon.svg'),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            controller.medicalSearchDetails
                                                .refresh();
                                            controller.selectedItems.refresh();
                                          },
                                          child: Text(
                                            'Refresh',
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
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Get.to(() => ShareResources());
                                  },
                                  child: Container(
                                    height: 42,
                                    width: 240,

                                    // Add margin between items
                                    decoration: BoxDecoration(
                                      color: Appcolors.themeColor
                                          .withOpacity(0.14),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                            'assets/svg/sendicon.svg'),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          'Share Resources',
                                          style: TextStyle(
                                            color: Appcolors.blackColor,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Divider(
                              color: Appcolors.themeColor.withOpacity(0.14),
                            )
                          ],
                        ),
                ),
                const SizedBox(
                  height: 5,
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
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: Appcolors.themeColor.withOpacity(0.44)),
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
                              const SizedBox(
                                width: 5,
                              ),
                              const SizedBox(width: 5),
                              GestureDetector(
                                  onTap: () {
                                    // Remove the item when delete icon is clicked
                                    controller.removeMedicalSearchDetails(item);
                                  },
                                  child: SvgPicture.asset(
                                      'assets/svg/deleteicon.svg')),
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
              return controller.medicalSearchDetails.isNotEmpty &&
                      searchboxEnable == false
                  ? ListView.builder(
                      shrinkWrap: true,
                      itemCount: controller.medicalSearchDetails.length,
                      itemBuilder: (context, index) {
                        final items = controller.medicalSearchDetails[index];
                        final heading = items["tl"] ?? 'unknown';
                        final details = items["dc"] ?? 'unknown';
                        final phone = items["ph"] ?? 'unknown';
                        final web = items["wb"] ?? 'unknown';
                        return Container(
                          margin: const EdgeInsetsDirectional.all(20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                heading,
                                style: TextStyle(
                                    color: Appcolors.TextColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                details,
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                    color: Appcolors.TextColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                phone,
                                style: TextStyle(
                                    color: Appcolors.TextColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600),
                              ),
                              Text(
                                web,
                                style: TextStyle(
                                    color: Appcolors.TextColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600),
                              )
                            ],
                          ),
                        );
                      })
                  : ListView.builder(
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
                            selected: true,
                            activeColor: Appcolors.themeColor,
                            onChanged: (bool? value) {
                              if (value == true) {
                                // Add the item if it is not already selected
                                controller.selectedItems.add(item);
                              } else {
                                // Remove the item if it is already selected
                                controller.selectedItems.removeWhere(
                                  (selectedItem) =>
                                      selectedItem['id'] == item['id'],
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
            return controller.medicalSearchDetails.isNotEmpty &&
                    searchboxEnable == false
                ? const SizedBox()
                : Visibility(
                    visible: controller.selectedItems.isNotEmpty ||
                        searchboxEnable == true,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Appcolors.themeColor.withOpacity(0.14),
                      ),
                      child: GestureDetector(
                        onTap: () async {
                          // Log selected items (already being shown in the box)
                          log("Proceed with selected items: ${controller.selectedItems}");
                          controller.fetchMedicalSearchDetails();
                          searchboxEnable.value = false;
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
