// ignore: file_names
import 'dart:typed_data';
import 'package:gps_map_app/Screens/Dashboard.dart/New_cases.dart/Accept/photo_capture.dart';
import 'package:gps_map_app/Screens/Dashboard.dart/New_cases.dart/Accept/untraceable.dart';
import 'package:flutter/material.dart';
import 'package:easy_stepper/easy_stepper.dart';


class TraceableScreenOfficeVerification extends StatefulWidget {
  const TraceableScreenOfficeVerification({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TraceableScreenOfficeVerificationState createState() => _TraceableScreenOfficeVerificationState();
}

class _TraceableScreenOfficeVerificationState extends State<TraceableScreenOfficeVerification> {
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
   final List<String> entryAlloweds = [
    'Allowed', 'Restricted'
  ];
  final List<String> indepenDent = ['Independent', 'Part of Independent', 'Attached'];

  String? selectedRelationship;
  String? selectedOwnership;
  String? selectedRoofType;
  String? selectedAreaType;
  String? entryAllowed;

  TextEditingController metPersonNameController = TextEditingController();
  TextEditingController applicantAgeController = TextEditingController();
  TextEditingController rentLeaseAmountController = TextEditingController();
  TextEditingController yearsOfStayingController = TextEditingController();
  TextEditingController totalFamilyMembersController = TextEditingController();
  TextEditingController numberOfEarnersController = TextEditingController();
  TextEditingController neighbourNameController = TextEditingController();
  TextEditingController kilometerController = TextEditingController();
  TextEditingController squareFeetController = TextEditingController();
  TextEditingController landAreaController = TextEditingController();
  TextEditingController constructionTypeController = TextEditingController();
  TextEditingController buildingTypeController = TextEditingController();
  TextEditingController constructionMaterialController = TextEditingController();
  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('Office Verification', style: TextStyle(color: Colors.white)),
        backgroundColor:  const Color(0xFF281C9D),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 5,
              child: Padding(
                padding: const EdgeInsets.all(16.0), // Add padding inside the Card
                child: EasyStepper(
                  activeStep: _activeStep,
                  direction: Axis.horizontal,
                  lineStyle: const LineStyle(
                    lineType: LineType.normal,
                    unreachedLineType: LineType.dotted,
                  ),
                  showTitle: false,
                  steps: [
                    EasyStep(
                      icon: Icon(Icons.home, color: _activeStep == 0 ? Colors.black : Colors.white, size: 24),
                      title: 'Step 1',
                      activeIcon:  const Icon(Icons.home, color: Color(0xFF281C9D)),
                      finishIcon:  const Icon(Icons.home, color: Color(0xFF281C9D)),
                    ),
               
                   
                    EasyStep(
                      icon: Icon(Icons.camera_alt, color: _activeStep == 5 ? Colors.black : Colors.white, size: 24),
                      title: 'Step 6',
                      activeIcon: const Icon(Icons.camera_alt, color: Color(0xFF281C9D)),
                    ),
                  ],
                  onStepReached: (index) {
                    setState(() {
                      _activeStep = index;
                    });
                  },
                ),
              ),
            ),
            if (_activeStep == 0) Container(
              padding: const EdgeInsets.all(16.0), // Outer padding
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _buildStep1(),
              ),
            ),
           
         
     
            if (_activeStep == 1) Container(
              padding: const EdgeInsets.all(10.0), // Outer padding
              child: Padding(
                padding: const EdgeInsets.all(16.0), // Inner padding
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _buildStep6(),
                ),
              ),
            ),
          
            Padding(
              padding: const EdgeInsets.all(1.0),
              child: Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF281C9D),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    child: Text(_activeStep == 1 ? 'Submit' : 'Next', style: const TextStyle(fontFamily: 'NA',color: Colors.white)),
                    onPressed: () {
                      if (_activeStep == 2) {
                        if (_validateStep6()) {
                          _showSuccessPopup();
                        }} else {
                     
                         if (_validateCurrentStep()) {
                          setState(() {
                            _activeStep++;
                          });
                        }
                      }
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _validateCurrentStep() {
    switch (_activeStep) {
      case 0:
        return _validateStep1();
      case 1:
        return _validateStep5();
     
      default:
        return false;
    }
  }
 final _formKey = GlobalKey<FormState>();
  final _formKey1 = GlobalKey<FormState>();
   final _formKey2 = GlobalKey<FormState>();
      // ignore: unused_field
      final _formKey3 = GlobalKey<FormState>();


  bool _validateStep1() {
     if (_formKey.currentState!.validate()) {
   
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Processing Data')),
      );
      return true;
    }  
    else{
      return false;
    }
  }
    
  

  // ignore: unused_element
  bool _validateStep2() {
   if (_formKey1.currentState!.validate()) {
      // If the form is valid, display a snackbar. In the real world,
      // you'd often call a server or save the information in a database.
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Processing Data')),
      );
      return true;
    }
    else{
      return false;
    }
  }

  // ignore: unused_element
  bool _validateStep3() {
    if (_formKey2.currentState!.validate()) {
      // If the form is valid, display a snackbar. In the real world,
      // you'd often call a server or save the information in a database.
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Processing Data')),
      );
      return true;
    }
    else{
      return false;
    }
  }

  // ignore: unused_element
  bool _validateStep4() {
    return kilometerController.text.isNotEmpty &&
           squareFeetController.text.isNotEmpty;
  }

  bool _validateStep5() {
    return landAreaController.text.isNotEmpty &&
           constructionTypeController.text.isNotEmpty &&
           buildingTypeController.text.isNotEmpty &&
           constructionMaterialController.text.isNotEmpty;
  }

  bool _validateStep6() {
    return entryAllowed != null;
  }

  void _showSuccessPopup() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Success', style: TextStyle(fontFamily: 'NA')),
          content: const Text('The form has been submitted successfully as Traceable.', style: TextStyle(fontFamily: 'NA')),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK', style: TextStyle(fontFamily: 'NA')),
            ),
          ],
        );
      },
    );
  }
  
final FocusNode entryAllowedFocusNode = FocusNode();
final FocusNode metPersonNameFocusNode = FocusNode();
final FocusNode relationshipFocusNode = FocusNode();
final FocusNode applicantAgeFocusNode = FocusNode();

List<Widget> _buildStep1() {
  return [
    Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildQuestionText('1. Entry Restricted/Entry Allowed?'),
          _buildDropdownField(
            hint: 'Select options',
            value: entryAllowed,
            items: entryAlloweds,
            focusNode: entryAllowedFocusNode,
            onChanged: (value) {
              setState(() {
                entryAllowed = value;
                FocusScope.of(context).requestFocus(metPersonNameFocusNode);
              });
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please select an option';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          _buildQuestionText('2. Met person name?'),
          _buildTextField(
            controller: metPersonNameController,
            focusNode: metPersonNameFocusNode,
            labelText: 'Enter Name',
            onFieldSubmitted: (_) {
              FocusScope.of(context).requestFocus(relationshipFocusNode);
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the name of the person met';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          _buildQuestionText('3. Designation of met person'),
          _buildDropdownField(
            hint: 'Select options',
            value: selectedRelationship,
            items: relationshipOptions,
            focusNode: relationshipFocusNode,
            onChanged: (value) {
              setState(() {
                selectedRelationship = value;
                FocusScope.of(context).requestFocus(applicantAgeFocusNode);
              });
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please select a relationship';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          _buildQuestionText('4. Designation of Applicant?'),
          _buildTextField(
            controller: applicantAgeController,
            focusNode: applicantAgeFocusNode,
            labelText: 'Enter Applicant Age',
            keyboardType: TextInputType.number,
            onFieldSubmitted: (_) {
              FocusScope.of(context).unfocus();
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the applicant age';
              } else {
                int? age = int.tryParse(value);
                if (age == null) {
                  return 'Please enter a valid number';
                } else if (age > 90) {
                  return 'Age cannot be greater than 90';
                }
              }
              return null;
            },
          ),
          const SizedBox(height: 30),
          _buildQuestionText('5. Years of working'),
          _buildDropdownField(
            hint: 'Select options',
            value: rentedOwnedLeased,
            items: ['Rented', 'Owned', 'Leased'],
            focusNode: rentedOwnedLeasedFocusNode,
            onChanged: (value) {
              setState(() {
                rentedOwnedLeased = value;
                if (value == 'Rented' || value == 'Leased') {
                  FocusScope.of(context).requestFocus(rentLeaseAmountFocusNode);
                } else {
                  FocusScope.of(context).requestFocus(yearsOfStayingFocusNode);
                }
              });
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please select an option';
              }
              return null;
            },
          ),
          if (rentedOwnedLeased == 'Rented' || rentedOwnedLeased == 'Leased') ...[
            const SizedBox(height: 20),
            _buildQuestionText('Rent/Lease Amount'),
            _buildTextField(
              controller: rentLeaseAmountController,
              focusNode: rentLeaseAmountFocusNode,
              labelText: 'Enter Amount',
              keyboardType: TextInputType.number,
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(yearsOfStayingFocusNode);
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the rent/lease amount';
                }
                return null;
              },
            ),
          ],
          const SizedBox(height: 20),
          _buildQuestionText('6. Name Board Displayed'),
          _buildTextField(
            controller: yearsOfStayingController,
            focusNode: yearsOfStayingFocusNode,
            labelText: 'Enter Years',
            keyboardType: TextInputType.number,
            onFieldSubmitted: (_) {
              FocusScope.of(context).requestFocus(totalFamilyMembersFocusNode);
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the years of staying';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          _buildQuestionText('7. Applicant Salary'),
          _buildTextField(
            controller: totalFamilyMembersController,
            focusNode: totalFamilyMembersFocusNode,
            labelText: 'Enter Number',
            keyboardType: TextInputType.number,
            onFieldSubmitted: (_) {
              FocusScope.of(context).requestFocus(numberOfEarningFocusNode);
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the total number of family members';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          _buildQuestionText('8. RCC/TILED/SHEET/HUT'),
          _buildTextField(
            controller: numberOfEarningController,
            focusNode: numberOfEarningFocusNode,
            labelText: 'Enter Number',
            keyboardType: TextInputType.number,
            onFieldSubmitted: (_) {
              FocusScope.of(context).requestFocus(numberOfDependentsFocusNode);
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the number of earning members';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          _buildQuestionText('9. Independent/part of Independent/Attached'),
          _buildTextField(
            controller: numberOfDependentsController,
            focusNode: numberOfDependentsFocusNode,
            labelText: 'Enter Number',
            keyboardType: TextInputType.number,
            onFieldSubmitted: (_) {
              FocusScope.of(context).requestFocus(applicantWorkingFocusNode);
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the number of dependents';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          _buildQuestionText('10. Square Feet'),
          _buildTextField(
            controller: applicantWorkingController,
            focusNode: applicantWorkingFocusNode,
            labelText: 'Name of the working company',
            onFieldSubmitted: (_) {
              FocusScope.of(context).requestFocus(applicantDesignationFocusNode);
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the name of the working company';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          _buildQuestionText('11. Type of Area'),
          _buildTextField(
            controller: applicantDesignationController,
            focusNode: applicantDesignationFocusNode,
            labelText: 'Name of the designation',
            onFieldSubmitted: (_) {
              FocusScope.of(context).requestFocus(applicantSalaryFocusNode);
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the name of the designation';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          _buildQuestionText('12. Neighbour Name'),
          _buildTextField(
            controller: applicantSalaryController,
            focusNode: applicantSalaryFocusNode,
            labelText: 'Enter Salary',
            keyboardType: TextInputType.number,
            onFieldSubmitted: (value) {
              FocusScope.of(context).requestFocus(roofTypeFocusNode);
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter applicant salary';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          _buildQuestionText('13. Kilometer'),
          _buildDropdownField(
            hint: 'Select Type',
            value: selectedRoofType,
            items: ['RCC', 'TILED', 'SHEET', 'HUT'],
            focusNode: roofTypeFocusNode,
            onChanged: (value) {
              setState(() {
                selectedRoofType = value;
              });
              FocusScope.of(context).requestFocus(propertyTypeFocusNode);
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please select an option';
              }
              return null;
            },
          ),
          
          const SizedBox(height: 20),
         
        ],
      ),
    ),
  ];
}

Widget _buildQuestionText(String question) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 5.0),
    child: Text(
      question,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
    ),
  );
}

Widget _buildDropdownField({
  required String hint,
  required String? value,
  required List<String> items,
  required FocusNode focusNode,
  required ValueChanged<String?> onChanged,
  required FormFieldValidator<String?> validator,
}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10.0),
    decoration: const BoxDecoration(
      border: Border(
        bottom: BorderSide(color: Colors.grey, width: 1.0),
      ),
    ),
    child: DropdownButtonFormField<String>(
      focusNode: focusNode,
      value: value,
      decoration: const InputDecoration(
        hintText: 'Select options',
        border: InputBorder.none,
      ),
      onChanged: onChanged,
      validator: validator,
      items: items
          .map((String value) => DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              ))
          .toList(),
    ),
  );
}

Widget _buildTextField({
  required TextEditingController controller,
  required FocusNode focusNode,
  required String labelText,
  TextInputType keyboardType = TextInputType.text,
  required FormFieldValidator<String?> validator,
  required ValueChanged<String?> onFieldSubmitted,
}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10.0),
    decoration: const BoxDecoration(
      border: Border(
        bottom: BorderSide(color: Colors.grey, width: 1.0),
      ),
    ),
    child: TextFormField(
      controller: controller,
      focusNode: focusNode,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: labelText,
        border: InputBorder.none,
      ),
      validator: validator,
      onFieldSubmitted: onFieldSubmitted,
    ),
  );
}

final FocusNode rentedOwnedLeasedFocusNode = FocusNode();
final FocusNode rentLeaseAmountFocusNode = FocusNode();
final FocusNode yearsOfStayingFocusNode = FocusNode();
final FocusNode totalFamilyMembersFocusNode = FocusNode();
final FocusNode numberOfEarningFocusNode = FocusNode();
final FocusNode numberOfDependentsFocusNode = FocusNode();
TextEditingController numberOfEarningController = TextEditingController();
TextEditingController numberOfDependentsController = TextEditingController();
String? rentedOwnedLeased;

final FocusNode applicantWorkingFocusNode = FocusNode();
TextEditingController applicantWorkingController = TextEditingController();

final FocusNode applicantDesignationFocusNode = FocusNode();
TextEditingController applicantDesignationController = TextEditingController();

  


  final numberOfEarnersFocusNode = FocusNode();

  FocusNode areaTypeFocusNode = FocusNode();
  // New controllers and focus nodes
  final applicantSalaryController = TextEditingController();
  final roofTypeController = TextEditingController();
  final propertyTypeController = TextEditingController();
    FocusNode applicantSalaryFocusNode = FocusNode();
  FocusNode squareFeetFocusNode = FocusNode();
  FocusNode neighbourNameFocusNode = FocusNode();
  FocusNode kilometerFocusNode = FocusNode();
 FocusNode roofTypeFocusNode = FocusNode();
  // Dropdown values
 FocusNode propertyTypeFocusNode = FocusNode();
  String? selectedPropertyType;

 



  




  List<Uint8List?> capturedImages = List.filled(5, null);
  
 // ignore: duplicate_ignore
 // ignore: unused_element
 void _capturePhoto(int photoNumber) {
    // Implement your photo capturing logic here
  }
  List<Widget> _buildStep6()  {
     // ignore: no_leading_underscores_for_local_identifiers
     void _showPhotoPreview(Uint8List imageBytes, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.memory(imageBytes, fit: BoxFit.cover),
              const SizedBox(height: 10),
              Text('Photo ${index + 1}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          ),
          actions: [
            SizedBox(
              width: double.infinity, // Full width
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF281C9D), // Theme color for button
                ),
                child: const Text('View full Screen',
                                      style: TextStyle(
                                        fontFamily: 'NA',
                                        color: Colors.white,
                                       
                                        fontWeight: FontWeight.bold,
                                      ),),
                onPressed: () {
                  Navigator.of(context).pop();
                
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FullScreenImageView(imageBytes: imageBytes, title: index,),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity, 
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF281C9D), 
                ),
                child: const Text('Retake Photo',
                                      style: TextStyle(
                                        fontFamily: 'NA',
                                        color: Colors.white,
                                       
                                        fontWeight: FontWeight.bold,
                                      ),),
                onPressed: () async {
                  Navigator.of(context).pop();
                  final newImageBytes = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const PhotoCaptureScreen()),
                  );
                  if (newImageBytes != null) {
                    setState(() {
                      capturedImages[index] = newImageBytes;
                    });
                  }
                },
              ),
            ),
            const SizedBox(height: 10), // Space before close button
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
    return [

            const Text('Capture Mandatory GPS Photos:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,  fontFamily: 'NA')),
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
                  onTap: () async {
                    if (capturedImages[index] == null) {
                      final imageBytes = await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const PhotoCaptureScreen()),
                      );
                      if (imageBytes != null) {
                        setState(() {
                          capturedImages[index] = imageBytes;
                        });
                      }
                    } else {
                      // Show preview of the captured photo
                      _showPhotoPreview(capturedImages[index]!, index);
                    }
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      capturedImages[index] != null
                          ? Image.memory(capturedImages[index]!, width: 100, height: 100) // Display captured image
                          : const Icon(Icons.camera_alt, size: 50, color: Colors.black),
                      const SizedBox(height: 5),
                      Text('Photo ${index + 1}', style: const TextStyle(color: Colors.black,  fontFamily: 'NA')),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 20),

    ];
     
  }
}


