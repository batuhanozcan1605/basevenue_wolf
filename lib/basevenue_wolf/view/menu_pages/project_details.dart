import 'dart:math';
import 'package:flutter/material.dart';
import '../../color_palette.dart';

class ProjectDetailsPage extends StatefulWidget {
  const ProjectDetailsPage({super.key});

  @override
  _ProjectDetailsPageState createState() => _ProjectDetailsPageState();
}

class _ProjectDetailsPageState extends State<ProjectDetailsPage> {
  String? _apiKey;

  void _generateApiKey() {
    setState(() {
      _apiKey = _generateDummyApiKey();
    });
  }

  static String _generateDummyApiKey() {
    final random = Random();
    return 'bvw-${random.nextInt(1000000)}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.background,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 66,),
            const Text(
              "Project Details",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 16),

            // Placeholder for project data
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: ColorPalette.secondaryBackground,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                "WHO KNOWS",
                style: TextStyle(fontSize: 16, color: Colors.white70),
              ),
            ),

            const SizedBox(height: 24),

            // Generate API Key Button
            ElevatedButton(
              onPressed: _generateApiKey,
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorPalette.primaryVariant,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text("Generate API Key", style: TextStyle(color: Colors.white)),
            ),

            const SizedBox(height: 16),

            // Display API Key if generated
            if (_apiKey != null)
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: ColorPalette.secondaryBackground,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _apiKey!,
                      style: const TextStyle(color: Colors.greenAccent, fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      icon: const Icon(Icons.copy, color: Colors.white70),
                      onPressed: () {
                        // TODO: Add copy-to-clipboard functionality
                      },
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 16),
            const Text("Main Token", style: TextStyle(color: Colors.white, fontSize: 24)),
            const SizedBox(height: 16),
            const Text("Game Tokens", style: TextStyle(color: Colors.white, fontSize: 24)),
          ],
        ),
      ),
    );
  }
}
