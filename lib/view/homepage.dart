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

  final Appcontroller appController = Get.put(Appcontroller());
  ScrollController scrollController = ScrollController();

  FocusNode searchFocusNode = FocusNode();
  var searchboxEnable = false.obs;

  // Filter search results based on query
  void _filterSearchResults(String query) {
    if (query.isEmpty) {
      appController.filteredMedicalSearch.clear(); // Ensure list is empty
    } else {
      appController.filteredMedicalSearch.assignAll(
        appController.medicalSearch.where((item) {
          final name = (item['nm'] ?? '').toString().toLowerCase();
          return name.contains(query.toLowerCase());
        }).toList(),
      );
    }
    appController.filteredMedicalSearch.refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: Customwidgets().customAppbar(),
      body: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 5),
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
                    controller: appController.searchController,
                    focusNode: searchFocusNode,
                    onChanged: _filterSearchResults,
                    cursorColor: Appcolors.themeColor,
                    decoration: InputDecoration(
                      hintText: 'Search here',
                      labelText: 'Search',
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 15,
                        color: Appcolors.hintColor,
                      ),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(15),
                        child: SvgPicture.asset(
                          'assets/svg/searchicon.svg',
                        ),
                      ),
                      suffixIcon: Container(
                        margin:
                            const EdgeInsets.only(right: 6, top: 6, bottom: 6),
                        width: 44,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: Appcolors.themeColor.withOpacity(0.14),
                        ),
                        child: Center(
                          child: GestureDetector(
                            onTap: () {
                              searchboxEnable.value = true;
                              appController.fetchMedicalSearch();
                            },
                            child: SvgPicture.asset(
                              'assets/svg/searchPrefixicon.svg',
                              height: 20,
                            ),
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
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Appcolors.themeColor),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Obx(
                  () => appController.medicalSearchDetails.isEmpty ||
                          searchboxEnable.value == true
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
                                    appController.medicalSearchDetails
                                        .refresh();
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
                                            appController.refreshData();
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
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      Get.to(() => ShareResources());
                                      appController.onClose();
                                    },
                                    child: Container(
                                      height: 42,

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
                Obx(() {
                  if (appController.selectedItems.isEmpty) {
                    return const SizedBox
                        .shrink(); // No display if no items selected
                  }
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics:
                        const BouncingScrollPhysics(), // Scroll horizontally
                    child: Row(
                      children: appController.selectedItems.map((item) {
                        final name = item['nm'] ?? 'Unknown Name';
                        return Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          margin: const EdgeInsets.only(
                              right: 10), // Add margin between items
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: Appcolors.blackColor.withOpacity(0.44)),
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
                                    appController
                                        .removeMedicalSearchDetails(item);
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
              // if (appController.filteredMedicalSearch.isEmpty) {
              //   // Placeholder shown when no search results
              //   return Center(
              //     child: SingleChildScrollView(
              //       physics: const BouncingScrollPhysics(),
              //       child: Column(
              //         mainAxisAlignment: MainAxisAlignment.center,
              //         children: [
              //           Stack(
              //             children: [
              //               Align(
              //                 alignment: Alignment.center,
              //                 child: SvgPicture.asset(
              //                   'assets/svg/backgroundimg.svg',
              //                   height:
              //                       MediaQuery.of(context).size.height * 0.25,
              //                 ),
              //               ),
              //               Align(
              //                 alignment: Alignment.center,
              //                 child: SvgPicture.asset(
              //                   'assets/svg/bgobjects.svg',
              //                   height:
              //                       MediaQuery.of(context).size.height * 0.2,
              //                 ),
              //               ),
              //             ],
              //           ),
              //           const SizedBox(height: 20),
              //           Text(
              //             'Search by keyword or select\ntopics from the list below',
              //             textAlign: TextAlign.center,
              //             style: TextStyle(
              //               color: Appcolors.hintColor,
              //               fontWeight: FontWeight.w400,
              //               fontSize: 20,
              //             ),
              //           ),
              //         ],
              //       ),
              //     ),
              //   );
              // }

              // if (appController.isLoading.value) {
              //   // Show CircularProgressIndicator when loading
              //   return Center(
              //     child: CircularProgressIndicator(
              //       color: Appcolors.themeColor, // Adjust the color as needed
              //       strokeWidth: 4.0,
              //     ),
              //   );
              // }

              if (appController.isLoading.value) {
                // Show CircularProgressIndicator when data is loading
                return Center(
                  child: CircularProgressIndicator(
                    color: Appcolors.themeColor, // Customizable color
                    strokeWidth: 4.0, // Adjust thickness if needed
                  ),
                );
              } else if (appController.filteredMedicalSearch.isEmpty || appController.isError.value) {
                // Show placeholder when no data is available
                return Center(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Your SVG assets and placeholder content
                        Stack(
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: SvgPicture.asset(
                                'assets/svg/backgroundimg.svg',
                                height:
                                    MediaQuery.of(context).size.height * 0.25,
                              ),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: SvgPicture.asset(
                                'assets/svg/bgobjects.svg',
                                height:
                                    MediaQuery.of(context).size.height * 0.2,
                              ),
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
              } else {
                // Show filtered search results
                return appController.medicalSearchDetails.isNotEmpty &&
                        searchboxEnable == false
                    ? ListView.builder(
                        shrinkWrap: true,
                        itemCount: appController.medicalSearchDetails.length,
                        itemBuilder: (context, index) {
                          final items =
                              appController.medicalSearchDetails[index];
                          final heading = items["tl"] ?? '';
                          final details = items["dc"] ?? '';
                          final phone = items["ph"] ?? '';
                          final web = items["wb"] ?? '';
                          return Container(
                            margin: const EdgeInsetsDirectional.all(20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  heading,
                                  textAlign: TextAlign.justify,
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
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      color: Appcolors.TextColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  web,
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                      color: Appcolors.TextColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                )
                              ],
                            ),
                          );
                        })
                    : ScrollbarTheme(
                        data: ScrollbarThemeData(
                          thumbColor: WidgetStatePropertyAll(
                              Appcolors.TextColor.withOpacity(0.44)),
                        ),
                        child: Scrollbar(
                          controller: scrollController,
                          thickness: 5,
                          thumbVisibility: true,
                          trackVisibility: true,
                          interactive: true,
                          radius: const Radius.circular(10),
                          child: ListView.builder(
                            controller: scrollController,
                            shrinkWrap: true,
                            itemCount:
                                appController.filteredMedicalSearch.length,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              final item =
                                  appController.filteredMedicalSearch[index];
                              final name = item['nm'] ?? 'Unknown Name';

                              return Obx(() {
                                // Check if the current item is selected
                                final isSelected =
                                    appController.selectedItems.any(
                                  (selectedItem) =>
                                      selectedItem['id'] == item['id'],
                                );

                                return CheckboxListTile(
                                  title: Text(
                                    name,
                                    style:
                                        TextStyle(color: Appcolors.TextColor),
                                  ),
                                  value: isSelected,
                                  selected: true,
                                  activeColor: Appcolors.themeColor,
                                  onChanged: (bool? value) {
                                    if (value == true) {
                                      // Add the item if it is not already selected
                                      appController.selectedItems.add(item);
                                    } else {
                                      // Remove the item if it is already selected
                                      appController.selectedItems.removeWhere(
                                        (selectedItem) =>
                                            selectedItem['id'] == item['id'],
                                      );
                                    }

                                    // Log the current selection for debugging
                                    log("Selected items: ${appController.selectedItems.map((e) => e['id'])}");

                                    // Notify the UI of changes
                                    appController.selectedItems.refresh();
                                  },
                                );
                              });
                            },
                          ),
                        ),
                      );
              }
            }),
          ),

          // Conditional Button at the Bottom
          Obx(() {
            return appController.medicalSearchDetails.isNotEmpty &&
                    searchboxEnable == false
                ? const SizedBox()
                : Visibility(
                    visible: appController.selectedItems.isNotEmpty ||
                        searchboxEnable == true,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          color: Appcolors.themeColor.withOpacity(0.14),
                          borderRadius: BorderRadius.circular(10)),
                      child: GestureDetector(
                        onTap: () async {
                          // Log selected items (already being shown in the box)
                          log("Proceed with selected items: ${appController.selectedItems}");
                          appController.fetchMedicalSearchDetails();
                          appController.searchController.clear();
                          searchboxEnable.value = false;
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/svg/searchicon.svg',
                              color: Appcolors.themeColor,
                            ),
                            const SizedBox(width: 15),
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
