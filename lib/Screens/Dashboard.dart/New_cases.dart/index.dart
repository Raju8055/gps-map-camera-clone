import 'dart:convert';
import 'package:gps_map_app/Screens/Dashboard.dart/New_cases.dart/Accept/index.dart';
import 'package:gps_map_app/utils/app_urls_constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// ignore: unused_import, depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:shared_preferences/shared_preferences.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;


// ignore: use_key_in_widget_constructors
class PendingCasesScreen extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _PendingCasesScreenState createState() => _PendingCasesScreenState();
}

class _PendingCasesScreenState extends State<PendingCasesScreen> {
  @override
  void initState() {
    super.initState();
    // Initialize with static data
    _loadStaticData();
  }

  // Static list of case data
  late List<Map<String, String>> cases = [];

  // Method to load static case data
  void _loadStaticData() {
    setState(() {
      cases = [
        {
          'customerPincode': '123456',
          'customerAddress': '123 Street, City',
          'caseId': 'C001',
          'customerName': 'John Doe',
          'productName': 'Product A',
          'intimationDateTime': '2024-10-01 12:30',
        },
        {
          'customerPincode': '654321',
          'customerAddress': '456 Avenue, City',
          'caseId': 'C002',
          'customerName': 'Jane Smith',
          'productName': 'Product B',
          'intimationDateTime': '2024-10-02 14:45',
        },
        {
          'customerPincode': '789123',
          'customerAddress': '789 Boulevard, City',
          'caseId': 'C003',
          'customerName': 'Alice Johnson',
          'productName': 'Product C',
          'intimationDateTime': '2024-10-03 09:15',
        },
        // Add more static cases as needed
      ];
    });
  }

  // Method to accept a case
  void _acceptCase(int index, String? casename, String? case_id) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LoanDetails(caseName: '$casename', caseID: case_id.toString()),
      ),
    );
  }

  // Method to reject a case
  void _rejectCase(int index) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Case Rejected'),
      backgroundColor: Colors.red,
    ));
  }

  // Refresh method (not needed with static data, but kept for completeness)
  Future<void> _refreshCases() async {
    // Refresh logic for static data
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'New Cases',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'NA',
            fontSize: 20,
          ),
        ),
        backgroundColor: const Color(0xFF281C9D),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: RefreshIndicator(
        onRefresh: _refreshCases,
        child: ListView.builder(
          itemCount: cases.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Slidable(
                key: Key(cases[index]['caseId']!),
                startActionPane: ActionPane(
                  motion: const DrawerMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (context) =>
                          _acceptCase(index, cases[index]['productName'], cases[index]['caseId']),
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      icon: Icons.check,
                      label: 'Accept',
                      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                      borderRadius: BorderRadius.circular(16.0),
                      flex: 1,
                    ),
                  ],
                ),
                endActionPane: ActionPane(
                  motion: const DrawerMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (context) => _rejectCase(index),
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      icon: Icons.delete,
                      label: 'Reject',
                      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                      borderRadius: BorderRadius.circular(16.0),
                      flex: 1,
                    ),
                  ],
                ),
                child: Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    side: BorderSide(color: Colors.black.withOpacity(0.3), width: 1.0),
                  ),
                  elevation: 3,
                  shadowColor: Colors.black.withOpacity(0.15),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                '${cases[index]['customerName']} (${cases[index]['productName']})',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF281C9D),
                                  fontFamily: 'NA',
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Case ID: ${cases[index]['caseId']}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'NA',
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        const Divider(color: Colors.grey, height: 1, thickness: 0.5),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(Icons.location_pin, size: 17, color: Colors.grey),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                '${cases[index]['customerAddress']}',
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.black87,
                                  fontFamily: 'FontMain2',
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              children: [
                                const FaIcon(FontAwesomeIcons.road, color: Color.fromARGB(94, 0, 0, 0), size: 17),
                                const SizedBox(width: 4),
                                Text(
                                  '${cases[index]['customerPincode']}',
                                  style: const TextStyle(fontSize: 12, fontFamily: 'NA'),
                                ),
                              ],
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${cases[index]['intimationDateTime']}',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontFamily: 'NA',
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
