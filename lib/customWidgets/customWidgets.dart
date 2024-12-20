import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:resource_plus/constants/colors.dart';
import 'package:resource_plus/controller/authController.dart';

final Authcontroller authcontroller = Get.put(Authcontroller());

class Customwidgets {
  AppBar customAppbar(
    bool isvalue,
    BuildContext context,
    bool isleading,
    
  ) {
    return AppBar(
      automaticallyImplyLeading: isleading,
      backgroundColor: Appcolors.backgroundColor,
      shadowColor: Colors.transparent,
      foregroundColor: Appcolors.backgroundColor,
      surfaceTintColor: Appcolors.backgroundColor,
      leading: isleading == true
          ? IconButton(onPressed: () { Get.toNamed('/');}, icon: Icon(Icons.arrow_back_rounded,color: Appcolors.blackColor,))
          : null,
      title: SvgPicture.asset(
        'assets/svg/applogo.svg',
        height: 25,
      ),
      actions: [
        isvalue
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: IconButton(
                  onPressed: () {
                    _showPopupMenu(context);
                  },
                  icon: Icon(Icons.menu, color: Appcolors.TextColor),
                ),
              )
            : SizedBox(),
      ],
    );
  }

  void _showPopupMenu(BuildContext context) async {
    final RenderBox overlay =
        Overlay.of(context)!.context.findRenderObject() as RenderBox;
    await showMenu(
      color: Colors.white,
      context: context,
      position: RelativeRect.fromLTRB(overlay.size.width - 100, 60, 0, 0),
      items: [
        // PopupMenuItem<String>(
        //   value: 'Profile',
        //   child: Row(
        //     children: [
        //       Icon(Icons.person, color:Appcolors.themeColor),
        //       SizedBox(width: 10),
        //       Text('Profile'),
        //     ],
        //   ),
        // ),
        // PopupMenuItem<String>(
        //   value: 'Change Password',
        //   child: Row(
        //     children: [
        //       Icon(Icons.lock, color: Appcolors.themeColor),
        //       SizedBox(width: 10),
        //       Text('Change Password'),
        //     ],
        //   ),
        // ),
        PopupMenuItem<String>(
          value: 'Logout',
          onTap: () => authcontroller.logout(),
          child: Row(
            children: [
              Icon(Icons.logout, color: Appcolors.themeColor),
              SizedBox(width: 10),
              Text('Logout'),
            ],
          ),
        ),
      ],
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
    bool obscureText = false,
  }) {
    return Stack(
      alignment: Alignment.centerLeft,
      clipBehavior: Clip.none,
      children: [
        TextFormField(
          cursorColor: Appcolors.themeColor,
          controller: controller,
          obscureText: obscureText,
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
    double? width,
  }) {
    return Container(
      height: 53,
      width: width,
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
