import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:resource_plus/constants/colors.dart';

class Customwidgets {
  AppBar customAppbar() {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Appcolors.backgroundColor,
      shadowColor: Colors.transparent,
      foregroundColor: Appcolors.backgroundColor,
      surfaceTintColor: Appcolors.backgroundColor,
      title: SvgPicture.asset(
        'assets/svg/applogo.svg',
        height: 25,
      ),
    );
  }

  Widget textFormField({
    TextEditingController? controller,
    String? hintText,
    String? labelText,
    String? Function(String?)? validator,
    FocusNode? focusNode,
    void Function()? onFocusChange,
    Widget? prefixIcon,
    Widget? suffixIcon,
    bool obsecureText=false ,
  }) {
    return Stack(
      alignment: Alignment.centerLeft,
      clipBehavior: Clip.none,
      children: [
        TextFormField(
          cursorColor: Appcolors.themeColor,
          controller: controller,
          obscureText: obsecureText,
          validator: validator,
          focusNode: focusNode,
          onFieldSubmitted: (value) => onFocusChange,
          decoration: InputDecoration(
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            hintText: hintText,
            hintStyle: TextStyle(
              color: Appcolors.hintColor.withOpacity(0.62),
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:
                  BorderSide(color: Appcolors.themeColor.withOpacity(0.79)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:
                  BorderSide(color: Appcolors.themeColor.withOpacity(0.79)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:
                  BorderSide(color: Appcolors.themeColor.withOpacity(0.79)),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:
                  const BorderSide(color: Color.fromARGB(255, 182, 48, 38)),
            ),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          ),
        ),
        Positioned(
          left: 12,
          top: -10,
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Text(
              labelText!,
              style: const TextStyle(
                color: Color(0xff7A7A7A),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Stack contentsharefields({
    TextEditingController? controller,
    String? hintText,
    String? labelText,
    String? Function(String?)? validator,
    FocusNode? focusNode,
    void Function()? onFocusChange,
    Widget? suffixIcon,
  }) {
    return Stack(
      alignment: Alignment.centerLeft,
      clipBehavior: Clip.none,
      children: [
        TextFormField(
          cursorColor: Appcolors.themeColor,
          controller: controller,
          validator: validator,
          focusNode: focusNode,
          onFieldSubmitted: (value) => onFocusChange,
          decoration: InputDecoration(
            suffixIcon: suffixIcon,
            hintText: hintText,
            hintStyle: TextStyle(
              color: Appcolors.hintColor.withOpacity(0.62),
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:
                  BorderSide(color: Appcolors.themeColor.withOpacity(0.79)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:
                  BorderSide(color: Appcolors.themeColor.withOpacity(0.79)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:
                  BorderSide(color: Appcolors.themeColor.withOpacity(0.79)),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:
                  const BorderSide(color: Color.fromARGB(255, 182, 48, 38)),
            ),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          ),
        ),
        Positioned(
          left: 12,
          top: -10,
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Text(
              labelText!,
              style: const TextStyle(
                color: Color(0xff7A7A7A),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Container customContainer({
    String? text,
  }) {
    return Container(
      height: 51,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Appcolors.themeColor.withOpacity(0.14)),
      child: Center(
        child: Text(
          text!,
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: Appcolors.themeColor),
        ),
      ),
    );
  }
}




// title: Text.rich(
      //   TextSpan(
      //     children: [
      //       TextSpan(
      //         text: 'Re.',
      //         style: TextStyle(
      //             color: Appcolors.themeColor,
      //             fontWeight: FontWeight.w700,
      //             fontSize: 30.69), // Normal text
      //       ),
      //       TextSpan(
      //         text: 'source',
      //         style: TextStyle(
      //             color: Appcolors.blackColor,
      //             fontWeight: FontWeight.w700,
      //             fontSize: 30.69), // Normal text
      //       ),
      //       WidgetSpan(
      //         child: Transform.translate(
      //           offset: const Offset(0, -5), // Adjust the vertical position
      //           child: Text(
      //             '+', // Superscript text
      //             style: TextStyle(
      //                 color: Appcolors.themeColor,
      //                 fontWeight: FontWeight.w700,
      //                 fontSize: 30.69), // Smaller font size
      //           ),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
