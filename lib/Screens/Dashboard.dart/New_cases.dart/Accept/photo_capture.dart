import 'dart:typed_data';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:geocoding/geocoding.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as img;
import 'package:geolocator/geolocator.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PhotoCaptureScreen extends StatefulWidget {
  const PhotoCaptureScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PhotoCaptureScreenState createState() => _PhotoCaptureScreenState();
}

class _PhotoCaptureScreenState extends State<PhotoCaptureScreen> {
  CameraController? _cameraController;
  late List<CameraDescription> _cameras;
  Position? _currentPosition;
  String _currentAddress = '';
  String _dateTime = '';
  int _selectedCameraIdx = 0; 

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse && permission != LocationPermission.always) return;
    }

    _currentPosition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
    List<Placemark> placemarks = await placemarkFromCoordinates(
        _currentPosition!.latitude, _currentPosition!.longitude);
    Placemark place = placemarks[0];
    _currentAddress = "${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}";
    _dateTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

    if (mounted) {
      setState(() {
        _initializeCamera(); 
      });
    }
  }

  Future<void> _initializeCamera() async {
    _cameras = await availableCameras();
    _cameraController = CameraController(_cameras[_selectedCameraIdx], ResolutionPreset.high);
   

    final cameraPermission = await _requestCameraPermission();
    if (cameraPermission != PermissionStatus.granted) {
      
      return;
    }

    await _cameraController?.initialize();
    setState(() {});
  }

  Future<PermissionStatus> _requestCameraPermission() async {
    final status = await Permission.camera.status;
    if (status.isGranted) {
      return PermissionStatus.granted;
    } else if (status.isDenied) {
      final result = await Permission.camera.request();
      return result.isGranted ? PermissionStatus.granted : PermissionStatus.denied;
    }
    return PermissionStatus.denied;
  }

  Future<void> _takePicture() async {
    if (!_cameraController!.value.isInitialized) return;
    if (_cameraController!.value.isTakingPicture) return;

    try {
      final Directory extDir = await getApplicationDocumentsDirectory();
      final String dirPath = '${extDir.path}/Pictures/flutter_test';
      await Directory(dirPath).create(recursive: true);
      final String filePath = '$dirPath/${DateTime.now().millisecondsSinceEpoch}.jpg';

      XFile file = await _cameraController!.takePicture();
      File savedImage = File(file.path).copySync(filePath);
      var imgBytes = await savedImage.readAsBytes();
      img.Image image = img.decodeImage(imgBytes)!;

      // Apply watermark
      _applyWatermark(image);

      Uint8List watermarkedImgBytes = Uint8List.fromList(img.encodeJpg(image));
      // ignore: use_build_context_synchronously
      Navigator.pop(context, watermarkedImgBytes); // Return the image bytes to the previous screen

    } catch (e) {
      print(e);
    }
  }

  void _applyWatermark(img.Image image) {
    int imgWidth = image.width;
    int imgHeight = image.height;
    String watermarkText = 'Address: $_currentAddress\nLatitude: ${_currentPosition!.latitude}\nLongitude: ${_currentPosition!.longitude}\nDate/Time: $_dateTime';


    int margin = 18;
    int textWidth = 800;
    int textHeight = 120;
    int startX = (imgWidth - textWidth) ~/ 10;
    int startY = imgHeight - textHeight - margin;

    img.fillRect(image, x1: startX, y1: startY, x2: startX + textWidth, y2: startY + textHeight, color: img.ColorFloat32.rgba(0, 0, 0, 0.541));

 
    img.drawString(image,
    watermarkText, font: img.arial24, x: startX + 10, y: startY + 10, color: img.ColorFloat32.rgba(255, 255, 255, 1));
  }

  void _switchCamera() {
    if (_cameras.length > 1) {
      _selectedCameraIdx = (_selectedCameraIdx + 1) % _cameras.length;
      print("zzzz8055 : $_selectedCameraIdx");
      _initializeCamera();
    }
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
     

    return Scaffold(
      backgroundColor: const Color.fromARGB(45, 0, 0, 0),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color(0xFF281C9D),
        title: const Text(
          'Capture Photo',
          style: TextStyle(fontFamily: 'NA', color: Colors.white),
        ),
        actions: [
          _cameraController == null || !_cameraController!.value.isInitialized
          ? Container():   IconButton(
            icon: const Icon(Icons.switch_camera),
            onPressed: _switchCamera,
          ),
        ],
      ),
      body:_cameraController == null || !_cameraController!.value.isInitialized
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    FontAwesomeIcons.cameraRetro,
                    color: Colors.white,
                    size: 48,
                  ),
                  // ignore: unnecessary_const
                  const SizedBox(height: 24),
                  // ignore: unnecessary_const
                  const Text(
                    'Initializing Camera...',
                    style: TextStyle(
                      fontFamily: 'NA',
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                  // ignore: unnecessary_const
                  const SizedBox(height: 24),
                  // ignore: unnecessary_const
                  const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ],
              ),
            )
          : Stack(
        children: [
          // Ensure the camera preview takes full height
          SizedBox.expand(
            child: CameraPreview(_cameraController!),
          ),
          Positioned(
            bottom: 30, // Adjust position as needed
            left: MediaQuery.of(context).size.width * 0.5 - 35, // Center the button
            child: GestureDetector(
              onTap: _takePicture, // Call the method to capture the picture
              child: Container(
                width: 70, // Width of the button
                height: 70, // Height of the button
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.black,
                    width: 4, // Border width
                  ),
                ),
                child: const Icon(
                  Icons.camera,
                  size: 40,
                  color: Color(0xFF281C9D), // Icon color
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 150, // Adjust position as needed
            left: 20,
            child: Card(
              color: const Color.fromRGBO(0, 0, 0, 0.541),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _currentAddress.isNotEmpty ? 'Address: $_currentAddress' : 'Loading... Please wait',
                      style: const TextStyle(color: Colors.white, fontFamily: 'NA', fontSize: 12),
                    ),
                    Text(
                      _currentPosition != null ? 'Latitude: ${_currentPosition!.latitude}' : 'Loading... Please wait',
                      style: const TextStyle(color: Colors.white, fontFamily: 'NA', fontSize: 12),
                    ),
                    Text(
                      _currentPosition != null ? 'Longitude: ${_currentPosition!.longitude}' : 'Loading... Please wait',
                      style: const TextStyle(color: Colors.white, fontFamily: 'NA', fontSize: 12),
                    ),
                    Text(
                      'Date/Time: $_dateTime',
                      style: const TextStyle(color: Colors.white, fontFamily: 'NA', fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
