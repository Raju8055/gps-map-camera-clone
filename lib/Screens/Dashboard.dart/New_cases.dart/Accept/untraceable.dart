import 'dart:typed_data';
import 'package:gps_map_app/Screens/Dashboard.dart/New_cases.dart/Accept/photo_capture.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UntraceableScreen extends StatefulWidget {
  const UntraceableScreen({super.key});

  @override
  _UntraceableScreenState createState() => _UntraceableScreenState();
}

class _UntraceableScreenState extends State<UntraceableScreen> {
  late List<Map<String, String>> reasons = [];

  @override
  void initState() {
    super.initState();
    print('initState called');
    _loadStaticReasons();
  }

  void _loadStaticReasons() {
    setState(() {
      reasons = [
        {'id': '1', 'reason': 'Reason 1'},
        {'id': '2', 'reason': 'Reason 2'},
        {'id': '3', 'reason': 'Reason 3'},
        {'id': '4', 'reason': 'Reason 4'},
        {'id': '5', 'reason': 'Reason 5'},
      ];
    });
    print('Static reasons loaded: $reasons');
  }

  String? selectedReason;
  List<Uint8List?> capturedImages = List.filled(10, null);

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
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF281C9D),
                ),
                child: const Text(
                  'View full Screen',
                  style: TextStyle(
                    fontFamily: 'NA',
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FullScreenImageView(imageBytes: imageBytes, title: index),
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
                child: const Text(
                  'Retake Photo',
                  style: TextStyle(
                    fontFamily: 'NA',
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
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
            const SizedBox(height: 10),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF281C9D),
        title: const Text(
          'Untraceable Case',
          style: TextStyle(color: Colors.white, fontFamily: 'NA'),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: reasons.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Select Reason:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'NA'),
                  ),
                  const SizedBox(height: 10),
                  DropdownButton<String>(
                    hint: const Text(
                      'Select a reason',
                      style: TextStyle(fontFamily: 'NA'),
                    ),
                    value: selectedReason,
                    isExpanded: true,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedReason = newValue;
                      });
                    },
                    items: reasons.map<DropdownMenuItem<String>>((Map<String, String> reason) {
                      return DropdownMenuItem<String>(
                        value: reason['id'],
                        child: Text(
                          reason['reason']!,
                          style: const TextStyle(fontFamily: 'NA'),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Capture Mandatory GPS Photos:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'NA'),
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
                            _showPhotoPreview(capturedImages[index]!, index);
                          }
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            capturedImages[index] != null
                                ? Image.memory(capturedImages[index]!, width: 100, height: 100)
                                : const Icon(Icons.camera_alt, size: 50, color: Colors.black),
                            const SizedBox(height: 5),
                            Text(
                              'Photo ${index + 1}',
                              style: const TextStyle(color: Colors.black, fontFamily: 'NA'),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        // Handle submission logic here
                      },
                      style: ElevatedButton.styleFrom(
                        side: const BorderSide(color: Color(0xFF281C9D), width: 2),
                        backgroundColor: const Color(0xFF281C9D),
                        padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 12.0),
                      ),
                      child: const Text('Submit', style: TextStyle(color: Colors.white, fontFamily: 'NA')),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

class FullScreenImageView extends StatelessWidget {
  final Uint8List imageBytes;
  final int title;

  const FullScreenImageView({Key? key, required this.imageBytes, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color(0xFF281C9D),
        title: Text('Photo ${title + 1}', style: const TextStyle(color: Colors.white)),
      ),
      body: Center(
        child: Image.memory(imageBytes, fit: BoxFit.cover),
      ),
    );
  }
}
