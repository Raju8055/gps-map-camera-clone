// ignore: unused_import
import 'dart:convert';
// ignore: unused_import
import 'package:gps_map_app/Screens/forgot_password.dart/new_password.dart';
import 'package:gps_map_app/utils/app_urls_constants.dart';
// ignore: unused_import, depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: unused_import
import 'package:shared_preferences/shared_preferences.dart';



class OtpVerification1 extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  final String mobileNumber;
  // ignore: use_key_in_widget_constructors
  const OtpVerification1({Key? key, required this.mobileNumber});

  @override
  // ignore: library_private_types_in_public_api
  _OtpVerification1State createState() => _OtpVerification1State();
}

class _OtpVerification1State extends State<OtpVerification1> {
  final List<TextEditingController> _otpControllers = List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

   Future<bool> _showConfirmationBottomSheet(BuildContext context) async {
    return await showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          color:Colors.white,
          height: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const ListTile(
                title: Center(
                  child: Text(
                    'Are you sure you want to exit the recording?',
                    style: TextStyle(
                      fontFamily: 'NA',
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(true); // Close the bottom sheet
                    },
                    style: ElevatedButton.styleFrom(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      backgroundColor:const Color(0xFF281C9D),
                    ),
                    child: const Text(
                      'Yes',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(false); // Pop with false indicating cancellation
                    },
                    style: ElevatedButton.styleFrom(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      backgroundColor: const Color.fromARGB(255, 60, 48, 170),
                    ),
                    child: const Text('No', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'NOTE: Once you exit the screen, the recorded session will not be available without submitting the recording.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey, // Adjusting text color
                  fontSize: 12, // Adjusting text size
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
          padding: const EdgeInsets.all(20.0),
          // ignore: deprecated_member_use
          child: WillPopScope(
      onWillPop: () async {
          // ignore: unnecessary_nullable_for_final_variable_declarations
          final bool? result = await _showConfirmationBottomSheet(context);
          return result ?? false; // Prevent default back button behavior based on user choice
      },
      child: SingleChildScrollView(
              child: Center(
                child: Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 70),
                      const Text(
                        'Enter Verification Code',
                        style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold, color: Colors.black, fontFamily: 'NA'),
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: Image.asset('assets/images/verification.png', height: 250),
                      ),
                      const SizedBox(height: 30),
                       Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Center(
                          child: Text(
                            'Kindly input the 6-digit code we have \n sent to you at  +91 - ${widget.mobileNumber}',
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.grey, fontFamily: 'NA'),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(6, (index) {
                          return SizedBox(
                            width: 40,
                            child: TextFormField(
                              controller: _otpControllers[index],
                              focusNode: _focusNodes[index],
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.grey[400],
                                contentPadding: EdgeInsets.zero,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                errorBorder: OutlineInputBorder(
                                  // ignore: prefer_const_constructors
                                  borderSide: BorderSide(color: Colors.red, width: 2.0),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                              inputFormatters: [LengthLimitingTextInputFormatter(1)],
                              onChanged: (value) {
                                if (value.isNotEmpty) {
                                  if (index < 5) {
                                    FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
                                  } else {
                                    FocusScope.of(context).unfocus();
                                  }
                                }
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return ' ';
                                }
                                return null;
                              },
                              style: const TextStyle(fontFamily: 'NA', fontSize: 24),
                            ),
                          );
                        }),
                      ),
                      const SizedBox(height: 20),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            'Didn’t receive the code?',
                            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey, fontFamily: 'NA'),
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          // Resend OTP code logic here
                        },
                        child: const Text(
                          'Resend Code',
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF5854D3), fontFamily: 'NA'),
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(width: double.infinity,child: ElevatedButton(style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(const Color.fromRGBO(88, 84, 211, 1)),),onPressed: _verifyOtp,
                       child: const Text('Verify',style: TextStyle(
        fontSize: 23,
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontFamily: 'NA',
      ),
    ),
  ),
)
,
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
    );
  }

  Future<void> _verifyOtp() async {
    if (_formKey.currentState!.validate()) {
    //  String otp = _otpControllers.map((controller) => controller.text).join();
    //   SharedPreferences prefs = await SharedPreferences.getInstance();
    // String? executiveId = prefs.getString('executiveId');
    // const url = '${AppUrls.mainURL}login/verify';
    // final response = await http.get(Uri.parse('$url?executiveId=$executiveId&executiveOTP=$otp'));
    // if (response.statusCode == 201) {
    //   final responseData = json.decode(response.body);
    //   int status = responseData['status'];
    //   if (status == 200) {
      if(mounted){
        showSuccessSnackBar(
     context,
      'Successful',
    '',
   );
Future.delayed(const Duration(seconds: 1), () {
    ScaffoldMessenger.of(context).hideCurrentSnackBar(); // Dismiss the SnackBar
     if (mounted) {
         Navigator.of(context).push(MaterialPageRoute(builder: (context) => const newpassword1()));
         }
   });
      }
      }else{
         // ignore: use_build_context_synchronously
         showWarningSnackBar(context,'Oops','',);
      }
  
            
// }else{
//     showWarningSnackBar(context,'Oops','Please Try again later',);
// }
//   }else {
//       // If the form is not valid, show an error message
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Please fill out all fields'),
//           backgroundColor: Colors.red,
//         ),
//       );
//     }
//   }
  }

void showWarningSnackBar(BuildContext context, String title, String message) {
    final snackBar = SnackBar(
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              const Icon(Icons.warning, color: Colors.orange),
              const SizedBox(width: 10),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.orange,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Text(
            message,
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
      backgroundColor: Colors.black87,
      duration: const Duration(seconds: 5),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.all(10),
      elevation: 6,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      action: SnackBarAction(
        label: 'Dismiss',
        onPressed: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        },
        textColor: Colors.orange,
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }


    void showSuccessSnackBar(BuildContext context, String title, String message) {
    final snackBar = SnackBar(
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              const Icon(Icons.check_circle, color: Colors.green),
              const SizedBox(width: 10),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.green,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Text(
            message,
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
      backgroundColor: Colors.black87,
      duration: const Duration(seconds: 5),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.all(10),
      elevation: 6,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      action: SnackBarAction(
        label: 'Dismiss',
        onPressed: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        },
        textColor: Colors.green,
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}