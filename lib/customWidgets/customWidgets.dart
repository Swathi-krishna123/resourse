import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:resource_plus/constants/colors.dart';

class Customwidgets {
  AppBar customAppbar() {
    return AppBar(
      toolbarHeight: 65,
      title: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: 'Re.',
              style: TextStyle(
                  color: Appcolors.themeColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 30.69), // Normal text
            ),
            TextSpan(
              text: 'source',
              style: TextStyle(
                  color: Appcolors.blackColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 30.69), // Normal text
            ),
            WidgetSpan(
              child: Transform.translate(
                offset: const Offset(0, -5), // Adjust the vertical position
                child: Text(
                  '+', // Superscript text
                  style: TextStyle(
                      color: Appcolors.themeColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 30.69), // Smaller font size
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextFormField textFormField({
    Function(String)? onChanged,
    TextEditingController? searchController,
  }) {
    return TextFormField(
      controller: searchController,
      decoration: InputDecoration(
          hintText: 'Search',
          hintStyle: TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 20,
              color: Appcolors.hintColor),
          prefixIcon: const Icon(Icons.search),
          suffixIcon: Container(
            margin: const EdgeInsets.only(right: 5),
            width: 44,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Appcolors.themeColor.withOpacity(0.14)),
            child: Center(
              child: SvgPicture.asset('assets/svg/searchPrefixicon.svg'),
            ),
          ),
          border: OutlineInputBorder(
            borderSide:
                BorderSide(color: Appcolors.themeColor.withOpacity(0.44)),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Appcolors.themeColor))),
      onChanged: onChanged
    );
  }
}
