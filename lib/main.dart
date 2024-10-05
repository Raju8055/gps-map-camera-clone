// ignore: unused_import
import 'package:gps_map_app/Screens/forgot_password.dart/index.dart';
import 'package:gps_map_app/Screens/forgot_password.dart/new_password.dart';
// ignore: unused_import
import 'package:gps_map_app/Screens/forgot_password.dart/otp_verify.dart';
import 'package:gps_map_app/Screens/forgot_password.dart/resetsuccessfull.dart';
// ignore: unused_import
import 'package:gps_map_app/Screens/Dashboard.dart/index.dart';
// ignore: unused_import
import 'package:gps_map_app/Screens/Dashboard.dart/map.dart';
import 'package:gps_map_app/Screens/login.dart';
import 'package:gps_map_app/Screens/splash_Screen.dart';
// ignore: unused_import 
import 'package:gps_map_app/test.dart';
import 'package:gps_map_app/utils/widgets/bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {      
   WidgetsFlutterBinding.ensureInitialized();
   runApp( MaterialApp(       
      title: '',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              fillColor: Colors.grey[200],
          contentPadding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
          labelStyle: const TextStyle(fontFamily: 'NA'),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            textStyle: const TextStyle(fontSize: 18),
            backgroundColor: const Color(0xFF281C9D),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: const Color.fromARGB(189, 113, 113, 113),
            textStyle: const TextStyle(fontSize: 16),
          ),
        ),
      ),
      initialRoute: '/',  
      routes: {
         '/' : (context) => const SplashScreen(),
         '/login' : (context) => const LoginScreen() ,
         '/home': (context) => MainScreen(),
         '/forgotscreen': (context) => const ForgotPasswordScreen(),
         '/newpassword' : (context) => const newpassword1(),
          '/resetsuccess' : (context) => const resetSuccessfull1(),
          }, 
    )); 
}

class ValidatePage extends StatefulWidget {
  const ValidatePage({super.key});
 
  @override
  // ignore: library_private_types_in_public_api
  _ValidatePageState createState() => _ValidatePageState();
}

class _ValidatePageState extends State<ValidatePage> {
  

  @override
  void initState() {
    super.initState();
    // Simulate a network request or some initialization task
    _initializePage();
  }

  Future<void> _initializePage() async {
       SharedPreferences prefs = await SharedPreferences.getInstance();

   // ignore: non_constant_identifier_names
   String? Usertoken = prefs.getString('Usertoken');
 

  if (Usertoken == null) {
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushNamedAndRemoveUntil(
                '/login', (Route<dynamic> route) => false);
     
    } else {
          // ignore: use_build_context_synchronously
          Navigator.of(context).pushNamedAndRemoveUntil(
                '/home', (Route<dynamic> route) => false);
  
    }
  
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      
      ),
      body: const Center(
        child: 
             CircularProgressIndicator() // Display the loader while loading
             // Display content after loading
      ),
    );
  }
}




