import 'package:gps_map_app/Screens/Dashboard.dart/New_cases.dart/Accept/TraceableOfficeverification.dart';
import 'package:gps_map_app/Screens/Dashboard.dart/New_cases.dart/Accept/TraceableResidenceVerification.dart';
import 'package:gps_map_app/Screens/Dashboard.dart/New_cases.dart/Accept/untraceable.dart';
import 'package:flutter/material.dart';

class LoanDetails extends StatefulWidget {
  final String caseName;
  final String caseID;

  const LoanDetails({super.key, required this.caseName, required this.caseID});
  @override
  _LoanDetailsScreenState createState() => _LoanDetailsScreenState();
}

class _LoanDetailsScreenState extends State<LoanDetails> {
  Map<String, dynamic>? caseDetails;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    // Instead of fetching, set static case details directly
    caseDetails = {
      'customerName': 'John Doe',
      'customerPhoneNumber': '9876543210',
      'alternatePhoneNumber': '1234567890',
      'customerAddress': '123 Main St, City, Country',
      'customerPincode': '560001',
      'clientName': 'ABC Bank',
      'productName': 'Personal Loan',
      'verificationTypeName': 'Residence',
    };
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF281C9D),
        title: Text("Case ID : ${widget.caseID}", style: const TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : caseDetails != null
              ? SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        LoanDetailColumn(
                          icon: Icons.person,
                          label: 'Name',
                          value: caseDetails!['customerName'] ?? 'N/A',
                        ),
                        LoanDetailColumn(
                          icon: Icons.phone,
                          label: 'Phone Number',
                          value: caseDetails!['customerPhoneNumber'] ?? 'N/A',
                        ),
                        LoanDetailColumn(
                          icon: Icons.phone_android,
                          label: 'Alternate Phone',
                          value: caseDetails!['alternatePhoneNumber'] ?? 'N/A',
                        ),
                        LoanDetailColumn(
                          icon: Icons.home,
                          label: 'Address',
                          value: caseDetails!['customerAddress'] ?? 'N/A',
                        ),
                        LoanDetailColumn(
                          icon: Icons.location_pin,
                          label: 'Pincode',
                          value: caseDetails!['customerPincode'] ?? 'N/A',
                        ),
                        LoanDetailColumn(
                          icon: Icons.business,
                          label: 'Client Name',
                          value: caseDetails!['clientName'] ?? 'N/A',
                        ),
                        LoanDetailColumn(
                          icon: Icons.account_balance,
                          label: 'Product Name',
                          value: caseDetails!['productName'] ?? 'N/A',
                        ),
                        LoanDetailColumn(
                          icon: Icons.verified_user,
                          label: 'Verification Type',
                          value: caseDetails!['verificationTypeName'] ?? 'N/A',
                        ),
                        const SizedBox(height: 20),
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return BottomSheetContent(
                                      type: caseDetails!['verificationTypeName']);
                                },
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              shadowColor: Colors.black,
                              minimumSize: const Size(120, 40),
                              backgroundColor: const Color(0xFF281C9D),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20.0,
                                vertical: 12.0,
                              ),
                            ),
                            child: const Text(
                              "Verify",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : const Center(child: Text("No case details available")),
    );
  }
}

class LoanDetailColumn extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const LoanDetailColumn({
    Key? key,
    required this.icon,
    required this.label,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label:  ',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 16,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            color: Colors.black54,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 1,
          color: Colors.grey[400],
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

class BottomSheetContent extends StatefulWidget {
  String? type;
  BottomSheetContent({super.key, required this.type});

  @override
  _BottomSheetContentState createState() => _BottomSheetContentState();
}

class _BottomSheetContentState extends State<BottomSheetContent> {
  String? _selectedOption = 'Traceable'; // Default option

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text('Select an option:', style: Theme.of(context).textTheme.titleLarge),
          ListTile(
            title: const Text('Traceable'),
            leading: Radio<String>(
              value: 'Traceable',
              groupValue: _selectedOption,
              onChanged: (value) {
                setState(() {
                  _selectedOption = value;
                });
              },
            ),
          ),
          ListTile(
            title: const Text('Untraceable'),
            leading: Radio<String>(
              value: 'Untraceable',
              groupValue: _selectedOption,
              onChanged: (value) {
                setState(() {
                  _selectedOption = value;
                });
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context); // Close the bottom sheet
              if (_selectedOption == 'Traceable') {
                if (widget.type == 'Residence') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TraceableScreenResidenceVerification(),
                    ),
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TraceableScreenOfficeVerification(),
                    ),
                  );
                }
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const UntraceableScreen(),
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF281C9D),
            ),
            child: const Text(
              '  Continue  ',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

