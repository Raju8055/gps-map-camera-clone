import 'dart:async';
import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class ResponsiveContent extends StatefulWidget {
  const ResponsiveContent({super.key});

  @override
  _ResponsiveContentState createState() => _ResponsiveContentState();
}

class _ResponsiveContentState extends State<ResponsiveContent> with SingleTickerProviderStateMixin {
  int _currentStep = 0;
  Timer? _timer;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _startTimer();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _animationController.dispose();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_currentStep < 5) {
          _currentStep++;
        } else {
          _currentStep = 0; // Reset the step to loop again
          timer.cancel(); // Cancel the timer after reaching 5
          _startTimer(); // Restart the timer
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 200),
              const Text('0.005 V', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 60)),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('0', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  const SizedBox(width: 10),
                  SizedBox(
                    height: 60, // Adjust height as needed
                    width: MediaQuery.of(context).size.width * 0.6, // Responsive width
                    child: StepProgressIndicator(
                      totalSteps: 20,
                      currentStep: _currentStep,
                      size: 20,
                      padding: 4,
                      selectedColor: Colors.blue,
                      unselectedColor: Colors.grey,
                      customStep: (index, color, _) => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        width: 20,
                        height: _currentStep == index ? 40 : (_currentStep > index ? 30 : 20),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [color.withOpacity(0.7), color],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: color.withOpacity(0.5),
                              blurRadius: 10,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: CustomPaint(
                          painter: WavePainter(
                            animation: _animationController,
                            color: color,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text('20', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                ],
              ),
              const SizedBox(height: 20),
              // Add more content here to ensure the scrollable area has enough content
            ],
          ),
        ),
      ),
    );
  }
}

class WavePainter extends CustomPainter {
  final Animation<double> animation;
  final Color color;

  WavePainter({required this.animation, required this.color}) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color.withOpacity(0.5);
    final path = Path();

    const waveHeight = 5;
    final waveLength = size.width / 4;
    final waveSpeed = animation.value * waveLength;

    path.moveTo(0, size.height);
    for (double i = 0; i <= size.width; i += waveLength / 2) {
      path.quadraticBezierTo(
        i + waveSpeed - waveLength / 4, size.height - waveHeight,
        i + waveSpeed, size.height,
      );
      path.quadraticBezierTo(
        i + waveSpeed + waveLength / 4, size.height + waveHeight,
        i + waveSpeed + waveLength / 2, size.height,
      );
    }
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
