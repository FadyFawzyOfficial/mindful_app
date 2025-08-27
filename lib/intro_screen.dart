import 'package:flutter/material.dart';
import 'package:mindful_app/data/sp_helper.dart';

import 'settings_screen.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  var _name = '';
  var _image = 'Lake';

  @override
  void initState() {
    super.initState();
    final settings = SPHelper().getSettings();
    settings.then((value) {
      setState(() {
        _name = value[SPHelper.nameKey] ?? '';
        _image = (value[SPHelper.imageKey] ?? 'Lake').toLowerCase();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Welcome Screen')),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset('assets/images/$_image.jpg', fit: BoxFit.cover),
          ),
          Align(
            alignment: Alignment(0, -0.5),
            child: Text(
              'Welcome $_name',
              style: TextStyle(
                color: Colors.white,
                shadows: [
                  Shadow(
                    blurRadius: 10,
                    color: Colors.black,
                    offset: Offset(5, 5),
                  ),
                ],
                fontSize: 24,
              ),
            ),
          ),
          Align(
            alignment: Alignment(0, 0.5),
            child: ElevatedButton(
              onPressed: () => Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (context) => SettingsScreen())),
              child: Text('Start'),
            ),
          ),
        ],
      ),
    );
  }
}
