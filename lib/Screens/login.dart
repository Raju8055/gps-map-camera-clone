// ignore_for_file: unused_import

import 'dart:convert';
import 'package:gps_map_app/Screens/forgot_password.dart/index.dart';
import 'package:gps_map_app/main.dart';
import 'package:gps_map_app/utils/app_urls_constants.dart';
import 'package:gps_map_app/utils/widgets/bottom_navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// ignore: unused_import
import 'package:gps_map_app/Screens/Dashboard.dart/index.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

void main() {
  runApp( const MaterialApp(
    home: LoginScreen(),
    debugShowCheckedModeBanner: false,
    
  ));
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _passwordVisible = false;
  

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
  }
 final FocusNode _passwordFocusNode = FocusNode();
 
Future<void> _login() async{
 if (_formKey.currentState!.validate()) {


  //  String mobileNumber = _usernameController.text;
  //     String password = _passwordController.text;
     

  //     const url = '${AppUrls.mainURL}login';
  //   final response = await http.get(Uri.parse('$url?executiveMobile=$mobileNumber&executivePassword=$password'));
    
   
    
    // if (response.statusCode == 201) {
    //   final responseData = json.decode(response.body);
    //   int status = responseData['status'];
   
      
    //   if (status == 200) {
    //        _setpreference(mobileNumber, password);
            final SharedPreferences prefs = await SharedPreferences.getInstance();
         await prefs.setString('Usertoken', "ACTIVE");
        if(mounted){
     // Show the success SnackBar
   showSuccessSnackBar(
    context,
    'Login Successful',
    'You have successfully logged in.',
  );

  // Wait for a short duration before navigating to the home screen
  Future.delayed(const Duration(seconds: 1), () {
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).hideCurrentSnackBar(); // Dismiss the SnackBar
 
        Navigator.push(
                        // ignore: use_build_context_synchronously
                        context,
                        MaterialPageRoute(builder: (context) =>  const ValidatePage()),
                      );
  });
       
       } // Use responseData directly instead of decoding again
} else {
if(mounted){
       showWarningSnackBar(context,'Opps', 'User with this Mobile Number does not exist');}// Use responseData directly instead of decoding again
      }
    // } else {
    //  // ignore: use_build_context_synchronously
    //  showWarningSnackBar(context,'Opps', 'Failed to log in. Please try again');}
     
    // } else {
    //             showWarningSnackBar(
    //               context,
    //               'Login Failed',
    //               'Please check your Mobile Number and password.',
    //             );
    //           }
}

//  Future<void> _setpreference(mobileNumber, password)async {
//      final SharedPreferences prefs = await SharedPreferences.getInstance();
//       // ignore: unused_local_variable
//       var mobilenumber1 = await prefs.setString('mobileNumber', mobileNumber);
//        await prefs.setString('password',password);
      
//    }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));

// ignore: unused_element

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
                          height: constraints.maxHeight * 0.25,
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                SizedBox(height: constraints.maxHeight * 0.03),
                                const Text(
                                  'Welcome Back!',
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
                                  'Hello there, sign in to continue',
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
            onChanged: (value) {
                      if (value.length == 10) {
                        FocusScope.of(context).requestFocus(_passwordFocusNode);
                      }
                    },
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            controller: _passwordController,
              focusNode: _passwordFocusNode,
            obscureText: !_passwordVisible,
            decoration: InputDecoration(
              labelText: 'Password',
              prefixIcon: const Icon(Icons.lock),
              suffixIcon: IconButton(
                icon: Icon(
                  _passwordVisible ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    _passwordVisible = !_passwordVisible;
                  });
                },
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              }
              return null;
            },
          ),
           Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
              const SizedBox(width: 10,),
               TextButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => ForgotPasswordScreen()));
                //             Navigator.of(context).pushNamedAndRemoveUntil(
                // '/forgotscreen', (Route<dynamic> route) => false);
                        },
                        child: const Text('Forgot password?',style: TextStyle(fontFamily: 'NA',fontSize: 13,color: Colors.black),),
                      ),
             ],
           ),
          const SizedBox(height: 30.0),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF281C9D),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              padding: const EdgeInsets.symmetric(vertical: 16.0),
            ),
            onPressed: () async {
            
              _login();
              
            },
            child: const Text(
              'Sign in',
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
