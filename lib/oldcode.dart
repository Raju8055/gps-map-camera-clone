import 'package:flutter/material.dart';
import 'package:easy_stepper/easy_stepper.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      primaryColor: const Color(0xFF281C9D),
      fontFamily: 'NA',
    ),
    home: const TraceableScreen1(),
  ));
}

class TraceableScreen1 extends StatefulWidget {
  const TraceableScreen1({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TraceableScreenState createState() => _TraceableScreenState();
}

class _TraceableScreenState extends State<TraceableScreen1> {
  int _activeStep = 0;
  final List<String> relationshipOptions = [
    'Self', 'Father', 'Mother', 'Sister', 'Brother', 'Relative', 'Neighbour', 'Others'
  ];
  final List<String> areaTypeOptions = [
    'Middle class area', 'Commercial area', 'Industrial area', 'Village area'
  ];
  final List<String> roofTypeOptions = [
    'RCC', 'TILED', 'SHEET', 'HUT'
  ];
  final List<String> ownershipOptions = [
    'Rented', 'Owned', 'Leased'
  ];

  String? selectedRelationship;
  String? selectedOwnership;
  String? selectedRoofType;
  String? selectedAreaType;
  String? entryAllowed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('Residence Verification', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF281C9D),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            EasyStepper(
              activeStep: _activeStep,
              direction: Axis.horizontal,
              lineStyle: const LineStyle(
                lineType: LineType.normal,
                unreachedLineType: LineType.dotted,
              ),
              unreachedStepIconColor: Colors.white,
              unreachedStepBorderColor: Colors.black54,
              finishedStepBackgroundColor: Colors.deepPurple,
              unreachedStepBackgroundColor: Colors.deepOrange,
              showTitle: false,
              steps: [
                EasyStep(
                  icon: Icon(Icons.home, color: _activeStep == 0 ? Colors.black : Colors.white),
                  title:'Step 1',
                  activeIcon: const Icon(Icons.home, color: Color(0xFF281C9D)),
                  finishIcon: const Icon(Icons.home, color: Color(0xFF281C9D)),
                ),
                EasyStep(
                  icon: Icon(Icons.person, color: _activeStep == 1 ? Colors.black : Colors.white),
                  title:'Step 2',
                  activeIcon: const Icon(Icons.person, color: Color(0xFF281C9D)),
                ),
                EasyStep(
                  icon: Icon(Icons.photo_camera, color: _activeStep == 2 ? Colors.black : Colors.white),
                  title: 'Step 3',
                  activeIcon: const Icon(Icons.photo_camera, color: Color(0xFF281C9D)),
                ),
                EasyStep(
                  icon: Icon(Icons.location_on, color: _activeStep == 3 ? Colors.black : Colors.white),
                  title: 'Step 4',
                  activeIcon: const Icon(Icons.location_on, color: Color(0xFF281C9D)),
                ),
                EasyStep(
                  icon: Icon(Icons.map, color: _activeStep == 4 ? Colors.black : Colors.white),
                  title: 'Step 5',
                  activeIcon: const Icon(Icons.map, color: Color(0xFF281C9D)),
                ),
                EasyStep(
                  icon: Icon(Icons.camera_alt, color: _activeStep == 5 ? Colors.black : Colors.white),
                  title: 'Step 6',
                  activeIcon: const Icon(Icons.camera_alt, color: Color(0xFF281C9D)),
                ),
                EasyStep(
                  icon: Icon(Icons.check_circle, color: _activeStep == 6 ? Colors.black : Colors.white),
                  title: 'Step 7',
                  activeIcon: const Icon(Icons.check_circle, color: Color(0xFF281C9D)),
                ),
              ],
              onStepReached: (index) {
                setState(() {
                  _activeStep = index;
                });
              },
            ),
            const SizedBox(height: 20),
            if (_activeStep == 0) ..._buildStep1(),
            if (_activeStep == 1) ..._buildStep2(),
            if (_activeStep == 2) ..._buildStep3(),
            if (_activeStep == 3) ..._buildStep4(),
            if (_activeStep == 4) ..._buildStep5(),
            if (_activeStep == 5) ..._buildStep6(),
            if (_activeStep == 6) ..._buildStep7(),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_activeStep < 6) {
                  setState(() {
                    _activeStep++;
                  });
                } else {
                  // Submit the case as traceable
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF281C9D), // Your theme color
              ),
              child: Text(
                _activeStep < 6 ? 'Next Step' : 'Submit as Traceable',
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildStep1() {
    return [
      _buildQuestionField(
        'Entry Allowed / Entry Restricted',
        _buildCustomDropdown(
          'Entry Allowed / Entry Restricted',
          entryAllowed,
          ['Entry Allowed', 'Entry Restricted'],
          (newValue) {
            setState(() {
              entryAllowed = newValue;
            });
          },
        ),
      ),
      _buildQuestionField(
        'Met Person Name',
        _buildCustomTextField('Met Person Name'),
      ),
      _buildQuestionField(
        'Relationship with Applicant',
        _buildCustomDropdown(
          'Relationship with Applicant',
          selectedRelationship,
          relationshipOptions,
          (newValue) {
            setState(() {
              selectedRelationship = newValue;
            });
          },
        ),
      ),
      _buildQuestionField(
        'Applicant Age',
        _buildCustomTextField(
          'Applicant Age',
          keyboardType: TextInputType.number,
        ),
      ),
      _buildQuestionField(
        'Additional Question 1',
        _buildCustomTextField('Answer'),
      ),
      _buildQuestionField(
        'Additional Question 2',
        _buildCustomTextField('Answer'),
      ),
      _buildQuestionField(
        'Additional Question 3',
        _buildCustomTextField('Answer'),
      ),
    ];
  }

  List<Widget> _buildStep2() {
    return [
      _buildQuestionField(
        'Ownership Type',
        _buildCustomDropdown(
          'Ownership Type',
          selectedOwnership,
          ownershipOptions,
          (newValue) {
            setState(() {
              selectedOwnership = newValue;
            });
          },
        ),
      ),
      if (selectedOwnership == 'Rented' || selectedOwnership == 'Leased') ...[
        const SizedBox(height: 10),
        _buildQuestionField(
          'Rent/Lease Amount',
          _buildCustomTextField(
            'Rent/Lease Amount',
            keyboardType: TextInputType.number,
          ),
        ),
      ],
      _buildQuestionField(
        'Years of Staying',
        _buildCustomTextField(
          'Years of Staying',
          keyboardType: TextInputType.number,
        ),
      ),
      _buildQuestionField(
        'Total Family Members',
        _buildCustomTextField(
          'Total Family Members',
          keyboardType: TextInputType.number,
        ),
      ),
      _buildQuestionField(
        'Number of Earners',
        _buildCustomTextField(
          'Number of Earners',
          keyboardType: TextInputType.number,
        ),
      ),
      _buildQuestionField(
        'Number of Dependents',
        _buildCustomTextField(
          'Number of Dependents',
          keyboardType: TextInputType.number,
        ),
      ),
      _buildQuestionField(
        'Applicant Working Company',
        _buildCustomTextField('Applicant Working Company'),
      ),
    ];
  }

  List<Widget> _buildStep3() {
    return [
      _buildQuestionField(
        'Roof Type',
        _buildCustomDropdown(
          'Roof Type',
          selectedRoofType,
          roofTypeOptions,
          (newValue) {
            setState(() {
              selectedRoofType = newValue;
            });
          },
        ),
      ),
      _buildQuestionField(
        'Square Feet',
        _buildCustomTextField(
          'Square Feet',
          keyboardType: TextInputType.number,
        ),
      ),
      _buildQuestionField(
        'Type of Area',
        _buildCustomDropdown(
          'Type of Area',
          selectedAreaType,
          areaTypeOptions,
          (newValue) {
            setState(() {
              selectedAreaType = newValue;
            });
          },
        ),
      ),
      _buildQuestionField(
        'Neighbour Name',
        _buildCustomTextField('Neighbour Name'),
      ),
      _buildQuestionField(
        'Kilometer',
        _buildCustomTextField(
          'Kilometer',
          keyboardType: TextInputType.number,
        ),
      ),
      _buildQuestionField(
        'Additional Question 1',
        _buildCustomTextField('Answer'),
      ),
      _buildQuestionField(
        'Additional Question 2',
        _buildCustomTextField('Answer'),
      ),
    ];
  }

  List<Widget> _buildStep4() {
    return [
      _buildQuestionField(
        'Land Area',
        _buildCustomTextField(
          'Land Area',
          keyboardType: TextInputType.number,
        ),
      ),
      _buildQuestionField(
        'Construction Type',
        _buildCustomTextField('Construction Type'),
      ),
      _buildQuestionField(
        'Building Type',
        _buildCustomTextField('Building Type'),
      ),
      _buildQuestionField(
        'Construction Material',
        _buildCustomTextField('Construction Material'),
      ),
      _buildQuestionField(
        'Age of Construction',
        _buildCustomTextField(
          'Age of Construction',
          keyboardType: TextInputType.number,
        ),
      ),
      _buildQuestionField(
        'Owner Name',
        _buildCustomTextField('Owner Name'),
      ),
      _buildQuestionField(
        'Number of Floors',
        _buildCustomTextField(
          'Number of Floors',
          keyboardType: TextInputType.number,
        ),
      ),
    ];
  }

  List<Widget> _buildStep5() {
    return [
      _buildQuestionField(
        'Number of Rooms',
        _buildCustomTextField(
          'Number of Rooms',
          keyboardType: TextInputType.number,
        ),
      ),
      _buildQuestionField(
        'Total Floors',
        _buildCustomTextField(
          'Total Floors',
          keyboardType: TextInputType.number,
        ),
      ),
      _buildQuestionField(
        'Total Area in Sq.Ft.',
        _buildCustomTextField(
          'Total Area in Sq.Ft.',
          keyboardType: TextInputType.number,
        ),
      ),
      _buildQuestionField(
        'Has Balcony',
        _buildCustomDropdown(
          'Has Balcony',
          null,
          ['Yes', 'No'],
          (newValue) {},
        ),
      ),
      _buildQuestionField(
        'Has Lift',
        _buildCustomDropdown(
          'Has Lift',
          null,
          ['Yes', 'No'],
          (newValue) {},
        ),
      ),
      _buildQuestionField(
        'Parking Space',
        _buildCustomTextField('Parking Space'),
      ),
      _buildQuestionField(
        'Security Type',
        _buildCustomTextField('Security Type'),
      ),
    ];
  }

  List<Widget> _buildStep6() {
    return [
      _buildQuestionField(
        'Photographer Name',
        _buildCustomTextField('Photographer Name'),
      ),
      _buildQuestionField(
        'Camera Type',
        _buildCustomTextField('Camera Type'),
      ),
      _buildQuestionField(
        'Camera Model',
        _buildCustomTextField('Camera Model'),
      ),
      _buildQuestionField(
        'Photo Quality',
        _buildCustomTextField('Photo Quality'),
      ),
      _buildQuestionField(
        'Photo Resolution',
        _buildCustomTextField('Photo Resolution'),
      ),
      _buildQuestionField(
        'Photo File Size',
        _buildCustomTextField('Photo File Size'),
      ),
      _buildQuestionField(
        'Photo Format',
        _buildCustomTextField('Photo Format'),
      ),
    ];
  }

  List<Widget> _buildStep7() {
    return [
      const Text(
        'Capture Mandatory GPS Photos:',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 10),
      GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 5,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => _capturePhoto(index + 1),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.camera_alt, size: 50),
                const SizedBox(height: 8),
                Text('Photo ${index + 1}'),
              ],
            ),
          );
        },
      ),
    ];
  }

  Widget _buildQuestionField(String label, Widget field) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              fontFamily: 'NA',
            ),
          ),
          const SizedBox(height: 8),
          field,
        ],
      ),
    );
  }

  Widget _buildCustomTextField(String hintText, {TextInputType keyboardType = TextInputType.text}) {
    return TextField(
      decoration: InputDecoration(
        hintText: hintText,
        border: const OutlineInputBorder(),
      ),
      keyboardType: keyboardType,
    );
  }

  Widget _buildCustomDropdown(
    String hintText,
    String? selectedValue,
    List<String> options,
    void Function(String?) onChanged,
  ) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        hintText: hintText,
        border: const OutlineInputBorder(),
      ),
      value: selectedValue,
      items: options.map((option) {
        return DropdownMenuItem<String>(
          value: option,
          child: Text(option),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }

  void _capturePhoto(int photoNumber) {
    // Implement your photo capturing logic here
    // ignore: avoid_print
    print('Capture photo $photoNumber');
  }
}
