import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:resource_plus/constants/colors.dart';
import 'package:resource_plus/customWidgets/customWidgets.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              // App Name
              SvgPicture.asset(
                'assets/svg/applogo.svg',
                height: 30,
              ),
              const SizedBox(height: 15),
              // Title
              Text(
                'Password Reset',
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w700,
                    color: Appcolors.themeColor),
              ),
              const SizedBox(height: 10),
              // Subtitle
              Text(
                'We sent an OTP to tom*****@gmail.com',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16,
                    color: Appcolors.TextColor,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 30),
              // OTP Fields
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  6,
                  (index) => SizedBox(
                    width: 50,
                    height: 50,
                    child: TextField(
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Appcolors.backgroundColor)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        filled: true,
                        // ignore: deprecated_member_use
                        fillColor: Appcolors.themeColor.withOpacity(0.14),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Resend OTP
              Text(
                "Don't receive OTP code?",
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  // Add resend OTP logic here
                },
                child: Text(
                  'Resend OTP',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: Appcolors.blackColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              // Verify Button
              Customwidgets().customContainer(text: 'Verify & Continue'),
              Spacer(),
              // Custom Numeric Keyboard
              Expanded(
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 12,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    if (index == 9) {
                      return SizedBox.shrink(); // Empty space
                    } else if (index == 11) {
                      return ElevatedButton(
                        onPressed: () {
                          // Handle backspace
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[200],
                        ),
                        child: Icon(Icons.backspace_outlined),
                      );
                    } else {
                      final number = (index == 10) ? 0 : index + 1;
                      return ElevatedButton(
                        onPressed: () {
                          // Handle number input
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[200],
                        ),
                        child: Text(
                          '$number',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
              SizedBox(height: 50,),
            ],
          ),
        ),
      ),
    );
  }
}
