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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Customwidgets().customAppbar(),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search TextField
            TextFormField(
              controller: _searchController,
              onChanged: _filterSearchResults,
              decoration: InputDecoration(
                hintText: 'Search',
                hintStyle: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 20,
                  color: Appcolors.hintColor,
                ),
                prefixIcon: const Icon(Icons.search),
                suffixIcon: Container(
                  margin: const EdgeInsets.only(right: 5),
                  width: 44,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: Appcolors.themeColor.withOpacity(0.14),
                  ),
                  child: Center(
                    child: SvgPicture.asset('assets/svg/searchPrefixicon.svg'),
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
            const SizedBox(height: 20),

            // List or Placeholder
            Expanded(
              child: Obx(() {
                if (controller.filteredMedicalSearch.isEmpty) {
                  // Placeholder shown when no search results
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            SvgPicture.asset('assets/svg/backgroundimg.svg'),
                            SvgPicture.asset('assets/svg/bgobjects.svg'),
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
                  );
                }

                // Show filtered search results
                return ListView.builder(
                  itemCount: controller.filteredMedicalSearch.length,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    final item = controller.filteredMedicalSearch[index];
                    final id = item['id'] ?? 'Unknown ID';
                    final name = item['nm'] ?? 'Unknown Name';

                    log('ID: $id, Name: $name');

                    final isSelected = controller.selectedItems.contains(item);

                    return CheckboxListTile(
                      title: Text(name),
                      value: isSelected,
                      onChanged: (bool? value) {
                        if (value == true) {
                          controller.selectedItems.add(item);
                        } else {
                          controller.selectedItems.remove(item);
                        }
                        controller.selectedItems.refresh();
                      },
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
