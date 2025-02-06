import 'package:flutter/material.dart';

class TokenManagementPage extends StatefulWidget {
  const TokenManagementPage({super.key});

  @override
  _TokenManagementPageState createState() => _TokenManagementPageState();
}

class _TokenManagementPageState extends State<TokenManagementPage> {
  bool _isFormExpanded = false;

  final TextEditingController _projectNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _extrasController = TextEditingController();
  final TextEditingController _tokenNameController = TextEditingController();
  final TextEditingController _tokenSymbolController = TextEditingController();
  final TextEditingController _tokenFunctionalityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Supply Information Cards
          Row(
            children: [
              _buildInfoCard("Total Supply", "1,000,000"),
              SizedBox(width: 16),
              _buildInfoCard("Circulating Supply", "750,000"),
            ],
          ),

          SizedBox(height: 24),

          // Create Token Button
          ElevatedButton(
            onPressed: () {
              setState(() {
                _isFormExpanded = !_isFormExpanded;
              });
            },
            child: Text("Create token for your project."),
          ),

          SizedBox(height: 16),

          // Expanded Form
          if (_isFormExpanded) Expanded(child: _buildTokenCreationForm()),

          // Submit Token Button
          if (_isFormExpanded) Align(
            alignment: Alignment.bottomLeft,
            child: ElevatedButton(
              onPressed: () {

              },
              child: Text("Submit Token"),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(String title, String value) {
    return Expanded(
      child: Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                value,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTokenCreationForm() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Project Details", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          _buildTextField("Project Name", _projectNameController),
          _buildTextField("Description", _descriptionController),
          _buildTextField("Extras", _extrasController),

          SizedBox(height: 16),

          Text("Token Details", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          _buildTextField("Token Name", _tokenNameController),
          _buildTextField("Token Symbol", _tokenSymbolController),
          _buildTextField("Token Functionality", _tokenFunctionalityController),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
