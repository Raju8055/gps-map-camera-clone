// ignore_for_file: unused_import

import 'package:gps_map_app/Screens/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
// ignore: duplicate_ignore
// ignore: unused_import




class resetSuccessfull1 extends StatefulWidget {
  const resetSuccessfull1({Key? key});

  @override
  _resetSuccessfull1State createState() => _resetSuccessfull1State();
}

class _resetSuccessfull1State extends State<resetSuccessfull1> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Center(
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 50),
                
                  const SizedBox(height: 20),
                  Center(
                    child: Image.asset('assets/images/Illustration1.png', height: 250),
                  ),

                  const SizedBox(height: 30),
                    const Text(
                    'Change password successfully!',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF281C9D),
                      fontFamily: 'NA',
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Center(
                      child: Text(
                        'Your new password is set successfully. Please login again with your new password.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                          fontFamily: 'NA',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 100), // Added extra space before the button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _navigateToLogin,
                      child: const Text(
                        'LOGIN',
                        style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: 'NA',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _navigateToLogin() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
  // ignore: unused_local_variable
  String? mobileNumber = prefs.getString('mobileNumber');
   // ignore: non_constant_identifier_names, unused_local_variable
   String? Usertoken = prefs.getString('Usertoken');
   print(Usertoken);
 Navigator.of(context).pushNamedAndRemoveUntil('/login',(Route<dynamic> route) =>false);
  }
}
