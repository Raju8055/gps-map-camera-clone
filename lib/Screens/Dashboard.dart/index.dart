// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
// ignore: unused_import
import 'dart:ffi';

// ignore: unused_import
import 'package:gps_map_app/Screens/Dashboard.dart/New_cases.dart/index.dart';
import 'package:gps_map_app/utils/app_urls_constants.dart';
import 'package:gps_map_app/utils/widgets/bottom_navigation.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
String? user_name;

String? new_cases;
String? assignedCases;
String? completedCases;

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchData();
   
  }

Future<void> _fetchData () async {
 
   SharedPreferences prefs = await SharedPreferences.getInstance();
    // ignore: duplicate_ignore
    // ignore: non_constant_identifier_names
    String? Usertoken = prefs.getString('Usertoken');
   
    const url = '${AppUrls.mainURL}login/profile';
    final headers = <String, String>{
      'Authorization': '$Usertoken',
    };
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
    
      );
      if (response.statusCode == 201) {
        final responseData = json.decode(response.body);
        int status = responseData['status'];
        String message = responseData['message'];
        if (status == 200) {
        setState(() {
           
            user_name = responseData['data']['executiveName'];
            new_cases = responseData['data']['dashboard']['newCases'].toString();
            assignedCases =  responseData['data']['dashboard']['assignedCases'].toString();
            completedCases = responseData['data']['dashboard']['completedCases'].toString();
          });
          
            final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('executiveId',  responseData['data']['executiveId']);

          } else if(status == 500 && message == "Expired token") {
             showErrorMessage('Token expired. Please log in to continue.');
             SharedPreferences prefs = await SharedPreferences.getInstance();
             await prefs.remove('Usertoken');
             await prefs.remove('mobileNumber');
             // ignore: use_build_context_synchronously
             Navigator.of(context).pushNamedAndRemoveUntil('/login',(Route<dynamic> route) =>false);}
      } else {
        // Handle non-200 status code
      }
    } catch (e) {
      // Handle network errors
    }
    
  }

void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    ).then((_) {});
  }

void _logoutModel(){
 showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return Container(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              const ListTile(
                                title: Text('Are you sure you want to logout?'),
                              ),
                              const SizedBox(height: 16.0),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () async {
                                        
                                        SharedPreferences prefs =
                                            await SharedPreferences
                                                .getInstance();
                                        await prefs.remove('Usertoken');
                                        await prefs.remove('mobileNumber');
                                        // ignore: use_build_context_synchronously
                                        Navigator.of(context)
                                            .pushNamedAndRemoveUntil(
                                                '/login',
                                                (Route<dynamic> route) =>
                                                    false);
                                      },
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          color: Color(0xFF281C9D),
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(4.0),
                                            bottomLeft: Radius.circular(4.0),
                                          ),
                                        ),
                                        child: const Padding(
                                          padding: EdgeInsets.all(12.0),
                                          child: Center(
                                            child: Text(
                                              "Yes",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 16.0),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.pop(
                                            context); // Close the bottom sheet
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color:
                                                const Color(0xFF281C9D),
                                            width: 2.0,
                                          ),
                                          borderRadius: const BorderRadius.only(
                                            topRight: Radius.circular(4.0),
                                            bottomRight: Radius.circular(4.0),
                                          ),
                                        ),
                                        child: const Padding(
                                          padding: EdgeInsets.all(12.0),
                                          child: Center(
                                            child: Text(
                                              "No",
                                              style: TextStyle(
                                                color: Color(0xFF281C9D),
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    );
                    }



  @override
  Widget build(BuildContext context) {
    final today = DateFormat('dd MMMM yyyy').format(DateTime.now());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF281C9D),
        title: const Text('Dashboard', style: TextStyle(fontFamily: 'NA', color: Colors.white)),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        actions: <Widget>[
          IconButton(
      icon: const Icon(Icons.logout),
      onPressed: () {
      _logoutModel();
      },
    ),
  ],
      ),
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
  decoration: const BoxDecoration(
    color: Color(0xFF281C9D),
  ),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const CircleAvatar(
        radius: 30,
        backgroundColor: Colors.white,
        child: Icon(
          Icons.person,
          color: Color(0xFF281C9D),
          size: 40,
        ),
      ),
      const SizedBox(height: 16),
      Text(
        'Welcome, $user_name',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          fontFamily: 'NA',
        ),
      ),
     
    ],
  ),
),
ListTile(
              leading: const Icon(Icons.dashboard),
              title: const Text('Dashboard', style: TextStyle(fontFamily: 'NA')),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(FontAwesomeIcons.newspaper),
              title: const Text('New Cases', style: TextStyle(fontFamily: 'NA')),
              onTap: () {
                 mainScreenKey.currentState?.onItemTapped(1);
              },
            ),
            ListTile(
              leading: const Icon(FontAwesomeIcons.clipboardCheck),
              title: const Text('Assigned Cases', style: TextStyle(fontFamily: 'NA')),
              onTap: () {
               mainScreenKey.currentState?.onItemTapped(2);
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profile', style: TextStyle(fontFamily: 'NA')),
              onTap: () {
               mainScreenKey.currentState?.onItemTapped(3);
              },
            ),
             ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout', style: TextStyle(fontFamily: 'NA')),
              onTap: () {
                Navigator.pop(context);
               _logoutModel();
              },
            ),
          
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              today,
              style: const TextStyle(
                color: Colors.black54,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                fontFamily: 'NA'
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                children: <Widget>[
                  _buildStatusCard(
                    context,
                    // ignore: prefer_const_constructors
                    icon:  FontAwesomeIcons.newspaper,
                    title: 'New Cases',
                    count: new_cases.toString(),
                  ),
                  _buildStatusCard(
                    context,
                    icon: Icons.assignment_add,
                    title: 'Assigned Cases',
                    count: assignedCases.toString(),
                  ),
                 _buildStatusCard(
                    context,
                    icon: FontAwesomeIcons.clipboardCheck,
                    title: 'Completed Cases',
                    count: completedCases.toString(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusCard(BuildContext context, {
    required IconData icon,
    required String title,
    required String count,
  }) {
      void navigateToAssignedCases() {
    mainScreenKey.currentState?.onItemTapped(1); // Navigate to Assigned Cases screen
  }
    return count.isEmpty ? const CircularProgressIndicator() : GestureDetector(
      onTap: () {
        if (title == 'New Cases') {
        navigateToAssignedCases();
        }
      },
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(
                icon,
                size: 36,
                color: const Color(0xFF281C9D),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xFF281C9D),
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'NA',
                ),
              ),
              const SizedBox(height: 8),
              // ignore: unnecessary_null_comparison
              count == null ? const CircularProgressIndicator() : Text(
                count,
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'NA',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile', style: TextStyle(fontFamily: 'NA',color: Colors.white)),
        backgroundColor: const Color(0xFF281C9D),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: const Center(
        child: Text('Profile Screen', style: TextStyle(fontFamily: 'NA')),
      ),
    );
  }
}


