import 'package:flutter/material.dart';

import 'data/sp_helper.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final _nameController = TextEditingController();
  final _images = ['Lake', 'Mountain', 'Sea', 'Country'];
  var _selectedImage = 'Lake';
  final _spHelper = SPHelper();

  @override
  void initState() {
    super.initState();
    getSettings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                hintText: 'Enter your name',
                labelText: 'Name',
              ),
            ),
            DropdownButton(
              value: _selectedImage,
              items: _images
                  .map(
                    (value) =>
                        DropdownMenuItem(value: value, child: Text(value)),
                  )
                  .toList(),
              onChanged: (newValue) =>
                  setState(() => _selectedImage = newValue ?? 'Lake'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => saveSettings().then((value) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(
                  value
                      ? 'The settings have been saved'
                      : 'Error: the settings were not saved',
                ),
              ),
            );
        }),
        child: const Icon(Icons.save_rounded),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<bool> saveSettings() async {
    return await _spHelper.setSettings(
      name: _nameController.text,
      image: _selectedImage,
    );
  }

  Future<void> getSettings() async {
    final settings = await _spHelper.getSettings();
    setState(() {
      _nameController.text = settings[SPHelper.nameKey] ?? '';
      _selectedImage = settings[SPHelper.imageKey] ?? 'Lake';
      _selectedImage = _selectedImage.isEmpty ? 'Lake' : _selectedImage;
    });
  }
}
