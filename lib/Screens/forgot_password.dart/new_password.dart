import 'dart:convert';
// ignore: unused_import
import 'package:gps_map_app/Screens/forgot_password.dart/resetsuccessfull.dart';
import 'package:gps_map_app/utils/app_urls_constants.dart';
// ignore: unused_import, depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
// ignore: unnecessary_import
import 'package:flutter/services.dart';
// ignore: unused_import
import 'package:shared_preferences/shared_preferences.dart';



// ignore: camel_case_types
class newpassword1 extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const newpassword1({Key? key});

  @override
  // ignore: library_private_types_in_public_api
  _newpassword1State createState() => _newpassword1State();
}

// ignore: camel_case_types
class _newpassword1State extends State<newpassword1> {
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _repeatPasswordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;
  bool _isRepeatPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
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
                          height: constraints.maxHeight * 0.3,
                          color: const Color(0xFF281C9D),
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
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 255, 255, 255),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(50),
                                topRight: Radius.circular(50),
                              ),
                            ),
                            padding: const EdgeInsets.all(20.0),
                            child: Center(
                                        child: Form(
                                          key: _formKey,
                                          autovalidateMode: AutovalidateMode.onUserInteraction,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              const SizedBox(height: 30),
                                              const Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 16.0),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text('Set new password',
style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold, color: Colors.black, fontFamily: 'NA'),
                                                    ),
                                                    SizedBox(height: 5),
                                                    Text(
                            'Set new login password for your account',
                            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.grey, fontFamily: 'NA'),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(height: 20),
                                              TextFormField(
                                                controller: _newPasswordController,
                                                obscureText: !_isPasswordVisible,
                                                decoration: InputDecoration(
                                                  labelText: 'New Password',
                                                  prefixIcon: const Icon(Icons.lock),
                                                  suffixIcon: IconButton(
                                                    icon: Icon(
                            _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                                                    ),
                                                    onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                                                    },
                                                  ),
                                                ),
                                                validator: (value) {
                                                  if (value == null || value.isEmpty) {
                                                    return 'Please enter your password';
                                                  } else if (value.length < 6) {
                                                    return 'Password must be at least 6 characters long';
                                                  }
                                                  return null;
                                                },
                                                style: const TextStyle(fontFamily: 'NA'), // Change font family for text inside text field
                                              ),
                                              const SizedBox(height: 30),
                                              TextFormField(
                                                controller: _repeatPasswordController,
                                                obscureText: !_isRepeatPasswordVisible,
                                                decoration: InputDecoration(
                                                  labelText: 'Repeat Password',
                                                  prefixIcon: const Icon(Icons.lock),
                                                  suffixIcon: IconButton(
                                                    icon: Icon(
                            _isRepeatPasswordVisible ? Icons.visibility : Icons.visibility_off,
                                                    ),
                                                    onPressed: () {
                            setState(() {
                              _isRepeatPasswordVisible = !_isRepeatPasswordVisible;
                            });
                                                    },
                                                  ),
                                                ),
                                                validator: (value) {
                                                  if (value == null || value.isEmpty) {
                                                    return 'Please repeat your password';
                                                  } else if (value != _newPasswordController.text) {
                                                    return 'Passwords do not match';
                                                  }
                                                  return null;
                                                },
                                                style: const TextStyle(fontFamily: 'NA'), // Change font family for text inside text field
                                              ),
                                              const SizedBox(height: 40),
                                              SizedBox(
                                                width: double.infinity,
                                                child: ElevatedButton(
                                                   
                                                  onPressed: _submit,
                                                  child: const Text(
                                                    'Change password',
                                                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white, fontFamily: 'FontMain3'),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 20),
                                            ],
                                          ),
                                        ),
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

  Future<void> _submit() async {
    if (_formKey.currentState?.validate() ?? false) {
       // String mobileNumber = _mobileNumberController.text;
//       String newPassword = _newPasswordController.text;
//       String repeatPassword = _repeatPasswordController.text;
//       if (newPassword == repeatPassword) {
//         SharedPreferences prefs = await SharedPreferences.getInstance();
//     // ignore: unused_local_variable
//     String? executiveId = prefs.getString('executiveId');
// const url = '${AppUrls.mainURL}login/newpassword';
//          final response = await http.get(Uri.parse('$url?executiveId=$executiveId&executivePassword=$newPassword&password_confirmation=$repeatPassword'));
//     if (response.statusCode == 201) {
//       final responseData = json.decode(response.body);
//       int status = responseData['status'];
//       if (status == 200) {
        if(mounted){
    showSuccessSnackBar(
     context,
      'Successful',
     '',
   );
   Future.delayed(const Duration(seconds: 1), () {
    ScaffoldMessenger.of(context).hideCurrentSnackBar(); // Dismiss the SnackBar
     if (mounted) {
          Navigator.of(context).pushNamedAndRemoveUntil(
                '/resetsuccess', (Route<dynamic> route) => false);
         }
   });
        }
    }
  }
   
//       } else {
//         if(mounted){
//            showWarningSnackBar(context,'Oops',responseData['message'],);
       
//         }
//        // Use responseData directly instead of decoding again
//       }
//     } else {
//       showWarningSnackBar(context,'Oops','Failed to log in. Please try again.',);
    
//     }
//       }
     
//   }
// }
// }


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
