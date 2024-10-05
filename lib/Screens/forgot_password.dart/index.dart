// ignore_for_file: unused_import

import 'dart:convert';
import 'package:gps_map_app/Screens/forgot_password.dart/index.dart';
import 'package:gps_map_app/Screens/forgot_password.dart/otp_verify.dart';
import 'package:gps_map_app/utils/app_urls_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  // ignore: unused_field
  final TextEditingController _passwordController = TextEditingController();
  // ignore: unused_field
  bool _passwordVisible = false;
  

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
  }
 // ignore: unused_field
 final FocusNode _passwordFocusNode = FocusNode();
 
// ignore: non_constant_identifier_names
Future<void> _verify_otpsend() async{
 if (_formKey.currentState!.validate()) {
  // String mobileNumber = _usernameController.text;
  //     const url = '${AppUrls.mainURL}login/forgot';
  //   final response = await http.get(Uri.parse('$url?executiveMobile=$mobileNumber'));
  //   if (response.statusCode == 201) {
  //     final responseData = json.decode(response.body);
  //     int status = responseData['status'];
  //     if (status == 200) {
  //    final SharedPreferences prefs = await SharedPreferences.getInstance();
  //       await prefs.setString('executiveId', responseData['data']['executiveId']);
        if(mounted){
  showSuccessSnackBar(
     context,
      'Successful',
     'Otp successfully sent to ${_usernameController.text}.',
   );
Future.delayed(const Duration(seconds: 1), () {
    ScaffoldMessenger.of(context).hideCurrentSnackBar(); // Dismiss the SnackBar
     if (mounted) {
         Navigator.of(context).push(MaterialPageRoute(builder: (context) => OtpVerification1(mobileNumber: _usernameController.text,)));

    }
   });
        }
      } else {
        if(mounted){
       showWarningSnackBar(context,'Login Failed','',);
        }
       // Use responseData directly instead of decoding again
      }
    }

// } else {
//   showWarningSnackBar(context,'Login Failed','Please check your Mobile Number.',);
//                 }
// }


  
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));


   return Scaffold(
  backgroundColor: Colors.white,
  body: LayoutBuilder(
    builder: (context, constraints) {
      return SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: constraints.maxHeight,
          ),
          child: IntrinsicHeight(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: constraints.maxHeight * 0.30,
                      decoration: const BoxDecoration(
                        color: Color(0xFF281C9D),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.arrow_back_ios),
                                  color: Colors.white,
                                  onPressed: () {
                                    // Add your onPressed code here!
                                    // ignore: avoid_print
                                    print('Back button pressed');
                                  },
                                ),
                                const SizedBox(width: 8),
                                const Text(
                                  'Sign in',
                                  style: TextStyle(
                                    fontFamily: 'NA',
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: constraints.maxHeight * 0.2),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(50),
                            topRight: Radius.circular(50),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                              offset: Offset(0, -5),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            SizedBox(height: constraints.maxHeight * 0.03),
                            const Text(
                              'Forgot Password',
                              style: TextStyle(
                                fontFamily: 'NA',
                                fontSize: 28.0,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF281C9D),
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 10.0),
                            Text(
                              'Please enter your details',
                              style: TextStyle(
                                fontFamily: 'NA',
                                fontSize: 16.0,
                                color: Colors.grey[600],
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: constraints.maxHeight * 0.03),
                            Center(
                              child: Image.asset(
                                'assets/images/Illustration.png',
                                width: constraints.maxWidth * 0.5,
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.all(12.0),
                              child: Text(
                                '6 Digit OTP will be sent to your registered mobile number to verify your details.',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                  fontFamily: 'NA',
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(height: constraints.maxHeight * 0.03),
                            _buildLoginForm(constraints),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  ),
);
  }

  Widget _buildLoginForm(BoxConstraints constraints) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            keyboardType: TextInputType.number,
            controller: _usernameController,
            decoration: InputDecoration(
              labelText: 'Mobile Number',
              prefixIcon: const Icon(Icons.call),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your Mobile Number';
              }else if(value.length > 10 || value.length < 10){
                return 'Please enter your valid 10 Digit Mobile Number';
                }else{
              return null;
              }
            },
            
          ),
         
         
          const SizedBox(height: 30.0),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF281C9D),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              padding: const EdgeInsets.symmetric(vertical: 10.0),
            ),
            onPressed: () async {
            
              _verify_otpsend();
              
            },
            child: const Text(
              'Submit',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'NA',
              ),
            ),
          ),
        ],
      ),
    );
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
}
