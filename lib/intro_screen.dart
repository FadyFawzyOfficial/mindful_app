import 'package:flutter/material.dart';

import 'data/sp_helper.dart';
import 'quote_screen.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  var _name = '';
  var _image = 'lake';

  @override
  void initState() {
    super.initState();
    SPHelper().getSettings().then((value) {
      if (value.isEmpty) return;
      setState(() {
        _name = value[SPHelper.nameKey] ?? '';
        _image = (value[SPHelper.imageKey]?.toLowerCase() ?? 'lake');
        _image = _image.isEmpty ? 'lake' : _image;
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
              ).push(MaterialPageRoute(builder: (context) => QuoteScreen())),
              child: Text('Start'),
            ),
          ),
        ],
      ),
    );
  }
}
